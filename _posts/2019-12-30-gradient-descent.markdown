---
layout: post
title:  "Gradient Descent"
date:   2019-12-30 22:21:32 -0700
categories: jekyll update
---

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

Jekyll requires blog post files to be named according to the following format:

`YEAR-MONTH-DAY-title.MARKUP`

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers, and `MARKUP` is the file extension representing the format used in the file. After that, include the necessary front matter. Take a look at the source for this post to get an idea about how it works.

You'll remember in OLS, we had something called the **normal equations** - a nice, succinct, simple formula for calculating out best-fit parameters. You'll also remember, then, that we had to invert an n by n matrix, $$X^TX$$ to get these parameters.. which, if n is large, is computationally very expensive. Today we'll discuss gradient descent, a less computationally expensive way (for large n) to obtain parameters that minimize our squared error.

It's important to first note that gradient descent is not limited to least squares. Gradient descent is just an algorithm that can be used to maximize (or minimize) any convex objective function by calculating the gradient at a point, taking a step in that direction, calculation the gradient again, taking a step in that direction... so on and so forth, until the gradient is basically norm 0. It just so happens that the least squares function is convex, so gradient descent converges to the minimum.

This algorithm won't work for non-convex functions as it may only search out a local minimum, not the global minimum. If you're standing at the base of two hills, the gradient is just going to take you up the steepest hill, not necessarily the tallest one, right? Okay.. anyways, do we remember what the gradient is?

Let's say we have

$$
J(\beta_0, \beta_1, \dots, \beta_q): \mathbb{R}^{q+1} \rightarrow \mathbb{R} 
$$

then, the gradient is defined as

$$
\nabla J = \frac{\partial J}{\partial \beta_0} \hat{e_1} + \dots + \frac{\partial J}{\partial \beta_q} \hat{e_{q+1}} = \begin{bmatrix} \frac{\partial J}{\partial \beta_0} \\ \vdots \\ \frac{\partial J}{\partial \beta_q} \end{bmatrix}
$$

so, essentially, each component of the gradient tells you how fast your function changes with respect to the standard basis in each direction. We can find the directional derivative of any unit vector $$ \vec{v}$$ by $$\nabla J \cdot \vec{v}$$

$$
\nabla J \cdot \vec{v} = \| \nabla J\|\|\vec{v}\|\cos(\theta) =\| \nabla J\|\cos(\theta)
$$

since $$\vec{v}$$ is a unit vector, where $$\theta$$ is the angle between the two vectors. $$\cos(\theta)$$ is max when $\theta = 0$ - that is, when $$\vec{v}$$ is in the direction of the gradient! So the steepest ascent is in the direction of the gradient, and the steepest descent is in the opposite direction. We should note that the steepest ascent here is limited to unit vectors, so the steepest ascent is really in the direction of $$\frac{\nabla J}{\| \nabla J\|}$$, right? But that's the same direction as the gradient. And we are going to kinda normalize the gradient in our own way later... you will see.

You can think of the gradient as kind of a trade-off. Say the gradient is $$<3,1,6>$$. You're confined to a circle in terms of where you can move with the gradient (or any vector) starting from a point. That is, there's a trade-off between directions. You can essentially trade 3 steps in the Y direction for one step in the X direction. So an optimal direction does just that, hence why the optimal direction is the gradient... it takes one 3 steps in the X direction for each step in the Y direction. Any other decision is 'unfair', i.e there is a better trade-off that maximizes how steep the gradient could be.

Anyways. The gradient heads in the direction of the steepest ascent, so an algorithm searching out the lowest point of a function should head in the opposite of the gradient. So let's consider least squares, where our squared error loss term is a function of $$ \mathbf{\beta} $$, the vector of parameters. That is,

$$
J(\beta_0, \dots, \beta_q) = \frac{1}{2n} \sum_{i=1}^n (\hat{y_i} - y_i)^2  =\frac{1}{2n} \sum_{i=1}^n ( \beta_0 + \beta_1x_{i1} + \dots + \beta_qx_{iq} - y_i )^2 
$$

where we just normalized the squared error function. Remember, $$q$$ is the number of features, and $$q+1$$ is the number of parameters we must estimate. Now, using a bit of calculus, we see that

$$
\frac{\partial J} {\partial \beta_0} = \frac{1}{n} \sum_{i=1}^n ( \hat{y_i} - y_i) 
$$

and, for $$j = 1,\dots, q$$,

$$
\frac{\partial J} {\partial \beta_j} = \frac{1}{n} \sum_{i=1}^n (\hat{y_i} - y_i)x_{ij} 
$$

so, a gradient descent algorithm would look something like

* is the norm of the gradient greater than our threshold? 
  * if yes, move along the gradient for each $$\beta_J$$ by some $$\alpha$$ and check again
  * if no, return the current point
  

where $$\alpha$$ is a stepsize of your choosing. It is important to note that the choice of the step-size is important. A step-size that is too big will cause the algorithm to jump over the minimum value and maybe even diverge, whereas a step-size that is too small will mean the algorithm takes forever to converge to the minimum value. In one dimension, we can see what is happening below.

![Different stepsizes](/assets/pics/lambda_tut.jpg)


When the step size is small (left), it is converging to the minimum value... but it is gonna take forever (maybe even actually. . .) and on the right, where the step size is too large, the minimum is being overshot and then the larger slope (gradient) is compounding with a large step size to overshoot by even more and so on and so forth as your algorithm sadly diverges to infinity ..... :(

You can imagine this type of computation is best done in a while-loop. Below is an interpretation of this algorithm in Julia: 

{% highlight julia %}

gradient_descent = function( X , y , β , α , threshold, intercept = true)
    if intercept
        if length(size(X)[2]) == length(β) - 1
            inter = ones(size(X)[1])
            X = hcat(inter,X)
        end
    end

    n = size(X)[1]
    q_plus_one = size(X)[2]
    e = 100
    gradient = zeros(q_plus_one)
    it = 0
    α = (α/n)

    while it < 10000 && e > threshold

        h = X*β
        error = h - y
        
        #for i in 1:q_plus_one
        #    gradient[i] = α*(error'*X[:,i])
        #end

        gradient = α * (X' * error)
        β = β - gradient

        e = norm(gradient)

        it = it + 1
    end

    return β, e
end 
{% endhighlight %}

The first part of this just says 'okay, did you add an intercept? maybe not.. because you might not think to add the column of ones... we are gonna assume you want to do this so we will do it for you if you did not'. Obviously, this isn't necessary, and could actually lead to incorrect results if the column  missing isn't the one of all ones, but it is just to show you that coding is YOUR life, do with it what you will... Anyways. We compute the gradient via the dot product, as you will notice that

$$ 
\sum_{i=1}^n (\hat{y_i} - y_i) = e^T \cdot \mathbf{1_n} 
$$

and

$$
\sum_{i=1}^n (\hat{y_i} - y_i)x_{ij} = e^T  \cdot \mathbf{X}[:,j] 
$$

where $$e$$ is the n-dimensional vector of errors and $latex X$ is the feature matrix, with a row of ones so that

$$
\sum_{i=1}^n (\hat{y_1} - y_i) = e^T \cdot \mathbf{X}[:,1] = e^T \cdot \mathbf{1_n} 
$$

We also add an iteration count (just in case our step size is too small or too large or we totally messed up the code) to stop the loop at a certain point. However, this way of thinking about the algorithm is commented out because it is not efficient. Generally, for-loops should (and usually can) be replaced by matrix multiplication, which is in the code above! Let's go ahead and see if we can see how you would write that 'in math'.....

You can see in the code that

$$
\nabla J = \mathbf{X^T(X\beta - Y)}
$$

which is actually just exactly what we wrote above. You're multiplying the errors by the columns of the feature matrix to get the components of the gradient, so why not just transpose your matrix and use matrix multiplication? Thats what this is saying. Thus,

$$
\mathbf{\beta^{(new)}} = \mathbf{\beta^{(old)}} - \alpha \frac{1}{n} \mathbf{X^T( X\beta - Y)} 
$$

Perfect. So now we know what it is, how to use it.. but when would you use it? Usually only when you have really large values of n (lots of observations, like millions...) . Essentially, the only reason you use it is time. There are other things you can do here, like use only one observation (which is called Least Mean Squares) which saves even more time but isn't as great, obviously. There are other issues with gradient descent, like correctly choosing the step-size that, in practice, you really have no way around. There are plenty of ways to choose a step-size, but no set-rule - you'll have to figure it out on your own (and that takes time, too!). What's best about gradient descent is that you can use it for a lot of things. Least squares is just one. You can use it for plenty of other things... really, you can use it for whatever problem you have where you need to optimize a function. But I hope learning about it via least squares was helpful!

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
