---
layout: post
title:  Intro to Inference 
date:   2020-01-10 10:00:00 -0700
---
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

Lots of people go through life talking about statistics and not actually knowing what a statistic *is*, sadly enough. The point of statistics, and statistical inference in general, is to make inferences about a *population* based off a sample. In general, you have a population parameter ($$\theta$$) that needs to be estimated (could be high - dimensional - the most we will talk about is *max* 2, so no worries) and some data (a random sample, once could say...) $$X_ 1, \dots, X_ n $$ from that population, from which we observe the data $$ x_ 1, \dots, x_ n$$. The goal of statistical inference is to take that sample and make really good educated guesses about the population and also make good, educated guesses about how good and educated your guess is. Make sense? I didn't think so. 

**Inference** is the process of drawing information about a population based off a sample (like I said above, with a fancy word defining it). The points is - probability theory is based on knowing $$ \theta $$. We never actually know $$ \theta $$, so to do anything in practice we need inference about $$\theta$$. Big time important. 

For example, we can make conclusions about the probability we get a certain number of successes in a certain number of trials (i.e Binomial($$n,p$$), or the probability that a certain metric is less than some value (i.e $$\mathcal{N}(\mu, \sigma^2$$)) - but that requires us to know the distribution those values follow in the population (i.e to know the population parameters). 

This post will be about a key concept in inference - the *sufficient statistic*. First - and back to the beginning - what is a statistic?! 

A statistics takes a random variable $$ \mathbf{X}$$ and maps it via some function $$T(.)$$. That is, 

$$
T(x_1, \dots, x_n) = T(\mathbf{X}): \mathbb{R}^n \rightarrow \mathbb{R}^m
$$

A few things. $$T(\mathbf{X})$$ is also a random variable, obviously. There is no restriction on $$m$$, but I think you probably get the idea that $$ m < n $$, because it doesn't really make sense to make our data more complicated. We also don't want to lose information in this mapping - this is a key point. For instance, if $$T(\mathbf{X}) = X_1$$, we have lost so much information contained in our data by using this transformation. 

So, in summary, we want to take our data and use some transformation $$T(\mathbf{X})$$ to make that data simpler and no less informative. That is what makes a good statistic good. This is why we use some statistics, and not others - as we will see. Anyways, this seems easy. Not like there's a million choices for $$T$$ or anything... 

## Sufficient Statistic

#### Definition

Anyways. Let's define what a sufficient statistic is. A statistic $$T(\mathbf{X})$$ is called a *sufficient statistic* for the parameter $$\theta$$ if the distribution of $$\mathbf{X}$$ given $$T(\mathbf{X})$$ does not depend on $$\theta$$. Why? This means that, given that we know the value of $$T(\mathbf{X})$$, the information left in the sample does not contain any information about $$\theta$$. This should be obvious - if the distribution of the data does not depend on the parameter, how can you get information about the parameter from that distribution ya know? Formally, if 

$$
f_{\mathbf{X}}(\mathbf{x} \vert T(\mathbf{X}) = t) = g(\mathbf{x})
$$

then $$T(\mathbf{X})$$ is sufficient for $$\theta$$. 

Let's look at an example: assume $$X_1, \dots, X_n \sim \textrm{Bernoulli}(p)$$ and $$T(\mathbf{X}) = \sum_{i=1}^n X_i$$. Is $$T$$ sufficient for $$p$$? Yep. Next. 

Just kidding. Let's see why. 

$$
f_{\mathbf{X}}(\mathbf{x} \vert T(\mathbf{X}) = t) = g(\mathbf{x}) = P(\mathbf{X} = \mathbf{x} \vert T(\mathbf{X}) = t) = \frac{P(\mathbf{X} = \mathbf{x}, T(\mathbf{X}) = t)}{P(T(\mathbf{X}) = t))}
$$

$$
= \begin{cases} 
	\frac{P(\mathbf{X} = \mathbf{x})}{P(T(\mathbf{X}) = t))} & \textrm{if} \; T(\mathbf{X}) = t \\
	0 & \textrm{else} 
 	\end{cases}
$$

(only considering the top case) 

$$
= \frac{f_{\mathbf{X}}(\mathbf{x} \vert p)}{q_{T(\mathbf{X})}(t \vert p)}
$$

Now, notice the distribution of $$T(\mathbf{X}) \sim \textrm{Binomial}(n,p)$$. Therefore, 

$$
\frac{f_{\mathbf{X}}(\mathbf{x})}{f_{T(\mathbf{X})}(t)} = \frac{\displaystyle\prod_{i=1}^n p^{x_i}(1-p)^{1 - x_i}}{\binom{n}{t}p^{\sum_{i=1}^n x_i}(1-p)^{n - \sum_{i=1}^n x_i}} =  \frac{1}{\binom{n}{t}}
$$

which doesn't contain $$p$$. So now - yep, $$T(\mathbf{X})$$ is sufficient for $$p$$! 

#### Theorem 1

Now, in typical fashion, lets define like a million more ways to show something is sufficient. The first - shown through example. From above we showed that the original definiton could  boil down to 

$$
\frac{f_{\mathbf{X}}(\mathbf{x} \vert \theta)}{q_{T(\mathbf{X})}(t \vert \theta)} = \frac{f_{\mathbf{X}}(\mathbf{x} \vert \theta)}{q(T(\mathbf{x}) \vert \theta)}
$$

so, if this ratio is free of $$\theta$$ for all $$ \mathbf{x}$$ in the support of $$\mathbf{X}$$, then $$(T(\mathbf{X})$$ is sufficient for $$\theta$$. 

So, the example above boils down to 

$$
\frac{\displaystyle\prod_{i=1}^n p^{x_i}(1-p)^{1 - x_i}}{\binom{n}{T(\mathbf{x})}p^{\sum_{i=1}^n x_i}(1-p)^{n - \sum_{i=1}^n x_i}} =  \frac{1}{\binom{n}{T(\mathbf{x})}}
$$

which does not depend on $$\theta$$ so we come to the same conclusion. This seems redundant. It is, really, but the benefit is we don't have to consider $$T(\mathbf{X}) = t$$ and $$T(\mathbf{X}) \neq t $$. So, originally, we *techincally* had to say that 0 did not depend on $$p$$, which is obvious. In this second definition, we don't even need to consider that. 

Let's try another example using this second definition of sufficiency. Let's check whether $$T(\mathbf{X}) = \bar{X}$$ is sufficient for $$\mu$$ in the normal distribution (with known variance $$\sigma^2$$). 

$$
f_X(x \vert \mu) = \frac{1}{\sqrt{2\pi\sigma^2}}\textrm{exp}\left( \frac{-(x - \mu)^2}{2\sigma^2}\right)
$$

Recall that $$\bar{X} \sim \mathcal{N}(\mu, \frac{\sigma^2}{n})$$. Therefore, 

$$
\frac{f_{\mathbf{X}}(\mathbf{x} \vert \mu)}{q(T(\mathbf{X}) \vert \mu)} = \frac{(\frac{1}{\sqrt{2\pi\sigma^2}})^n\textrm{exp}\left(- \displaystyle\sum_{i=1}^n\frac{(x_i - \mu)^2}{2\sigma^2}\right)}{\frac{\sqrt{n}}{\sqrt{2\pi\sigma^2}}\textrm{exp}\left( \frac{-n(\bar{x} - \mu)^2}{2\sigma^2}\right)} = \mathcal{K} \frac{\textrm{exp}\left(\frac{- \sum_{i=1}^n(x_i^2 - 2x_i\mu)}{2\sigma^2}\right)}{\textrm{exp}\left( \frac{2\bar{x}n \mu - n\bar{x}^2}{2 \sigma^2}\right)}
$$

$$
= \mathcal{K}\frac{\textrm{exp}\left( \frac{-\sum_{i=1}^{n}x_i^2}{2 \sigma^2}\right)}{\textrm{exp}\left(\frac{-n\bar{x}^2}{2 \sigma^2}\right)}
$$

which doesn't depend on $$\mu$$! So, the sample mean is a sufficient statistic for the population average in a normal distribution - hence why we use it all the time!

Now, moving on to even more ways to show sufficiency... 

#### Factorization Theorem

**Factorization Theorem** : $$T(\mathbf{X})$$ is sufficient if *and only if* there exists $$g(t\vert \theta)$$ and $$h(\theta)$$ such that $$\forall \mathbf{x}, \theta$$, 

$$
f_{\mathbf{X}}(\mathbf{x} \vert \theta) = g(T(\mathbf{x})\vert \theta)h(\mathbf{x})
$$

Since this is an *iff*, we have to prove it in both directions. First, 

**Proof**: Sufficiency $$\implies$$ Factorization 

This is the easy case. 

$$
f_{\mathbf{X}}(\mathbf{x}\vert \theta) = P(\mathbf{X} = \mathbf{x} \vert \theta)
$$

$$
= P(\mathbf{X} = \mathbf{x}, T(\mathbf{X}) = t \vert \theta)
$$

and, by the definition of conditional probability, 

$$
= P(T(\mathbf{X}) = t \vert \theta)P(\mathbf{X} = \mathbf{x} \vert T(\mathbf{X}) = t,\theta)
$$

and, by sufficiency (i.e. we assume given $$T(\mathbf{X})$$, the distribution of the data is free of $$\theta$$). 

$$
= P(T(\mathbf{X}) = t \vert \theta)P(\mathbf{X} = \mathbf{x} \vert T(\mathbf{X}) = t)
$$

$$
= g(t \vert \theta)h(\mathbf{x})
$$

and we have proved that direction. Now, 

**Proof**: Factorization $$\implies$$ Sufficiency 

Let $$q(y \vert \theta)$$ be the pmf of $$T(\mathbf{X})$$ and let $$A_t$$ be the set containing all the possible data that yield a statistics $$T(\mathbf{x}) = t$$. That is, 

$$
A_t = \{ \mathbf{y}: T(\mathbf{y}) = t\}
$$

Then, 

$$
q(t \vert \theta) = P(T(\mathbf{X}) = t \vert \theta) = \displaystyle\sum_{\mathbf{y} \in A_t} f_{\mathbf{X}}(\mathbf{y}\vert \theta)
$$

So, since we are assuming factorization, 

$$
\frac{f_{\mathbf{X}}(\mathbf{x}\vert\theta)}{q(t \vert \theta)} = \frac{g(T(\mathbf{x})\vert \theta)h(\mathbf{x})}{\sum_{\mathbf{y} \in A_t} f_{\mathbf{X}}(\mathbf{y}\vert \theta)}
$$

$$
 = \frac{g(T(\mathbf{x})\vert \theta)h(\mathbf{x})}{\sum_{\mathbf{y} \in A_t} g(T(\mathbf{y}) \vert \theta) h(\mathbf{y})}
$$

and, since for $$y \in A_t$$, $$T(\mathbf{y}) = t = T(\mathbf{x})$$

$$
= \frac{h(\mathbf{x})}{\sum_{y \in A_T}h(\mathbf{y})}
$$

and this does not ever depend on $$\theta$$, so $$T(\mathbf{X})$$ is sufficient and we have completed the proof! 

So, this makes things wicked easy.... let's go back to the two examples we have done above. First, $$\mathbf{X} \sim \textrm{Bernoulli}(p)$$.

$$
f(\mathbf{x} \vert p) = \displaystyle\prod p^{x_i}(1-p)^{1- x_i} = p^{\sum x_i}(1-p)^{n - \sum x_i} = p^t(1-p)^{n-t}
$$ 

and then $$g(t \vert p) = p^t(1-p)^{n-p}$$ and $$h(\mathbf{y}) = 1$$, then we can see that $$ \sum_{i= 1}^n X_i $$ is sufficient for $$p$$.

Now, let us consider the second, normal with known variance, example. 

$$
f_X(\mathbf{x} \vert \mu) = \displaystyle\prod_{i=1}^n \frac{1}{\sqrt{2\pi\sigma^2}}\textrm{exp}\left( \frac{-(x_i - \mu)^2}{2\sigma^2}\right)
$$

$$
 = \left(\frac{1}{\sqrt{2\pi\sigma^2}}\right) ^n \textrm{exp}\left( - \sum x_i^2 \right) \times \textrm{exp}\left( n(2 \mu \bar{x} - \mu) \right)
$$

so $$h(\mathbf{x}) = \left(\frac{1}{\sqrt{2\pi\sigma^2}}\right) ^n \textrm{exp}\left( - \sum x_i^2 \right)$$ and $$g(t \vert \mu) = \textrm{exp}\left( n(2 \mu \bar{x} - \mu) \right)$$ when $$t = \bar{x}$$, so the sample mean is sufficient for $$\mu$$. Way easier - we like that. 

Let's try a new example. Consider $$\mathbf{X} \sim \textrm{Uniform}(0,\theta)$$. What is a sufficient statistic for $$\theta$$? To assess this, let's use the factorization theorem. Remember, 

$$
f(x \vert \theta) = \begin{cases} 
\frac{1}{\theta} & \textrm{if} \; x \in [0,\theta] \\
0 & \textrm{else}
\end{cases}
$$ 

which is identical to 

$$
\frac{1}{\theta}I(0 \leq x) I (x \leq \theta)
$$

so, therefore, 

$$
f_{\mathbf{X}}(\mathbf{x} \vert \theta) = \displaystyle\prod_{i=1}^n \frac{1}{\theta}I(0 \leq x_i) I (x_i \leq \theta) = \theta^{-n}I(x_{(n)} \leq \theta) I(0 \leq x_{(1)}) 
$$

so we can conclude that the max, $$X_{(n)}$$, is a sufficient statistic for $$\theta$$.

Now, let's consider a two-dimensional (*whoa*) sufficient statistic! When I learned this, the professor made this seem very straight forward - but I know things get real iffy real quick when the dimension of things increase - so lets take it slow. What we are looking for now is $$T(\mathbf{X}) = (T_1(\mathbf{X}), T_2(\mathbf{X}))$$ such that the factorization theorem still applies. Let's consider a normal distribution with unknown variance. Now, what we need is to find a factorization 

$$
f_{\mathbf{X}}(\mathbf{x} \vert \mu, \sigma^2) = g(T_1(\mathbf{x}), T_2(\mathbf{X}) \vert \mu, \sigma^2)h(\mathbf{x})
$$

This differs from the one dimensional case where we kind of just tossed the parts of the exponent that did not depend on $$\mu$$ into the constant and called it a day. Now, we can do that but only for the parts of the exponent that don't depend on $$\mu$$ and $$\sigma^2$$ which is none of them so trick-statement you can't toss anything into the constant from the exponent. Turns out that constant infront isn't even a constant anymore since it involves $$\sigma^2$$. Bummer. All this means, though, is more algebra - which, although it is tedious, is not difficult if you pay attention (which *I know* is difficult). So, let's get to it. 

$$
f_{\mathbf{X}}(\mathbf{x} \vert \mu, \sigma^2) = \displaystyle\prod_{i=1}^n \frac{1}{\sqrt{2\pi\sigma^2}}\textrm{exp}\left( \frac{-(x_i - \mu)^2}{2\sigma^2}\right)
$$

$$
= \left( \frac{1}{\sqrt{2\pi\sigma^2}} \right) ^n \textrm{exp}\left( \frac{-\sum_{i=1}^n((x_i - \bar{x}) + (\bar{x} - \mu))^2}{2\sigma^2}\right)
$$

$$
= \left( \frac{1}{\sqrt{2\pi\sigma^2}} \right) ^n \textrm{exp}\left( \frac{-1}{2\sigma^2}\left(\sum_{i=1}^n(x_i - \bar{x})^2 +2 \sum_{i=1}^n(x_i - \bar{x})(\bar{x} - \mu)  - n(\bar{x} - \mu)^2\right)\right)
$$

and now note that 
$$
\sum_{i=1}^n(x_i - \bar{x})(\bar{x} - \mu) = \bar{x}\sum x_i - \mu\sum x_i - n\bar{x} + n\bar{x}\mu = 0
$$

so, therefore,  

$$
f_{\mathbf{X}}(\mathbf{x} \vert \mu, \sigma^2) = \left( \frac{1}{\sqrt{2\pi\sigma^2}} \right) ^n \textrm{exp}\left( \frac{-1}{2\sigma^2}\left(\sum_{i=1}^n(x_i - \bar{x})^2 - n(\bar{x} - \mu)^2\right)\right)
$$

and by using $$h(\mathbf{x}) = 1$$, we have the factorization theorem! Therefore, 

$$

T(\mathbf{X}) = (T_1(\mathbf{X}), T_2(\mathbf{X})) = (\bar{X}, \sum_{i=1}^n (X_i - \bar{X})^2)

$$

is a sufficient statistic for $$\mathbf{\phi} = (\mu, \sigma^2)$$

Let's try another one - $$\mathbf{X} \sim \textrm{Uniform}(\alpha, \theta)$$. Extending our knowledge of the one-dimensional case, this should be fairly simple. 

$$
f_{\mathbf{X}}(\mathbf{x} \vert \theta, \alpha) = \displaystyle\prod_{i=1}^n \frac{1}{\theta - \alpha}I(\alpha \leq x_i) I (x_i \leq \theta) = (\theta - \alpha)^{-n}I(x_{(n)} \leq \theta) I(\alpha \leq x_{(1)}) 
$$

so we can conclude that 

$$
T(\mathbf{X}) = (T_1(\mathbf{X}), T_2(\mathbf{X})) = (X_{(1)}, X_{(n)})
$$

is suffcient for $$\phi = (\alpha,\theta)$$

## Minimal Sufficient Statistic 

As you have (hopefully) noticed, sufficient statistics are not even close to unique. For instance, the sample itself is always sufficient. The order statistics are also always sufficient as we can set $$h(\mathbf{x})$$ to be 1 and then the joint distribution is the same, just reordered (see the examples section for more detials on this). Also, any one-to-one function of a sufficient statistic is also a sufficient statistic, as that value maps uniquely back to the original sufficient statistic. Therefore, we need some notion of *better* when it comes to these types of statistics. That is what the idea of a **minimal sufficient statistic** is.  The idea is to find a sufficient statistic that is more sufficent than the rest - i.e. one that has the property of maximum data reduction? The defintion of the minimal sufficient statistic is as follows: 

A sufficient statistic $$T(\mathbf{X})$$ is a minimal sufficient statistic if, for every other suffcient statistic $$T'(\mathbf{X})$$, $$T(\mathbf{X})$$ is a function of $$T'(\mathbf{X})$$. 

This definition is fairly unclear, in my humble opinion. I guess not unclear, but fails to provide the intuition behind it. So lets try to explain it a bit better. The idea behind sufficient statistics was to reduce to data into a **coarser** partition, without losing information about the parameter of interest. We now want the coarsest partition of data we can get - the maximum data reduction. So lets consider a function, $$f(x)$$. Remember, a function is defined such that, if $$x_1 = x_2$$, $$f(x_1) = f(x_2)$$ - but this does not mean that if $$f(x_1) = f(x_2)$$, then $$x_1 = x_2$$. What does this mean in our case? It means, if we have a partition, we can make it more coarse (i.e the domain smaller) by finding a function of that partition that maps to a smaller partition. That is, if $$x_1$$ and $$x_2$$ are partitions of a sample space $$\mathcal{X}$$, then a function can **only** map to a coarser partition. That is, a function will map both to the same partition if they are the same, but may also map them to the same partition if they are different. Also, a function will hit all values in its outcome space. So, at worst, a function will map all partitions in the first partition space to all partions in the other sample space and, at best, will map a few of the original partitions to the same partition. Therefore, a function makes the sample space more coarse. So, if $$T$$ is a function of all other $$T'$$, then it is a partition is the most coarse - it has the maximum reduction of data. This is a nice definition but, in practice, it does not really help us. The following is a theorem that *can* help: 

The ratio $$\frac{f(\mathbf{x} \vert \theta)}{f(\mathbf{y} \vert \theta)}$$ is free of $$\theta$$ *if and only if* $$T(\mathbf{x}) = T(\mathbf{y})$$, then then $$T(\mathbf{X})$$ is a minimal sufficient statistic. 

This is helpful! We can use this practically. The proof is a bit difficult, but you can see this definition as arising from the Factorization Theorem. Before we see some examples with some known distributions, lets talk facts about this minimal sufficient statistic. 

Is a minimal sufficient statistic unique? **No**. It turns out that any injective function of $$T(\mathbf{X})$$ is also a minimal sufficient statistic. Why does this make sense? Intuitively, a one to one function of $$T(\mathbf{X})$$ maps the partitions created by $$T(\mathbf{X})$$ uniquely to partitions in a different partitioned space. Since $$T(\mathbf{X})$$ is a minimal sufficient statistic, it achieves the coarsest possible partition space (i.e with the smallest cardinality), so the mapping of a function of $$T(\mathbf{X})$$ has to map to the smallest number of possible partitions, by default. 

A more formal proof is as follows. To understand why this proof is as follows, remember that *only* a 1-1 function has an inverse: 

**Proof**: 
(*Sufficiency*) 

Let $$T^*(\mathbf{X}) = b(T(\mathbf{X}))$$ be a one-to-one function. Then, $$\exists \; b^{-1}$$ such that $$b^{-1}(T^*(\mathbf{X})) = T(\mathbf{X})$$. Thus, knowing $$T^*(\mathbf{X})$$ assures that we know $$T(\mathbf{X})$$ via $$b^{-1}(.)$$. We can also see that, by the factorization theorem, when $$T$$ is sufficient, $$\exists \; h, \; g$$ such that $$ f(\mathbf{x} \vert \theta) = g(T(\mathbf{x}) \vert \theta)h(\mathbf{x}) = g(b^{-1}(T^*(\mathbf{X}))\vert \theta)h(\mathbf{x})$$. Thus, $$T^*(\mathbf{X})$$ is sufficient for $$\theta$$. 

The proof for minimal sufficiency is quite straightforward, just noticing that if two statistics are equal, a one-to-one function of those two statistics will also be equal. 

And... now to examples, so you can pass your class. ;).

Lets go back to the OG example of this post. Let $$X_1, \dots, X_n \sim \textrm{Binomial}(n,p)$$. Is $$\sum X_i$$ a minimal sufficient statistic? We know it is sufficient because we already proved it so refresh your memory if you already forgot about this. To prove minimal sufficiency, we have to prove it both ways. So first, lets look at the ratio 

$$
\frac{f_{\mathbf{X}}(\mathbf{x} \vert p)}{f_{\mathbf{X}}(\mathbf{y} \vert p)} = \frac{\binom{n}{\sum x_i}p^{\sum x_i}(1-p)^{n - \sum x_i}}{\binom{n}{\sum y_i}p^{\sum y_i}(1-p)^{n - \sum y_i}} \propto_{p} p^{\sum x_i - \sum y_i}(1-p)^{\sum y_i - \sum x_i}
$$

Now, if $$\sum y_i = \sum x_i$$, then the ratio is 1 and thus free of $$p$$. If the ratio is free of $$p$$ only if $$\sum y_i = \sum x_i$$, so then $$\displaystyle\sum_{i=1}^n X_i$$ is a minimal sufficient statistic for $$p$$. Great - now lets look at an example where something might not be a minimal sufficient statistic in this same data. Consider the case where $$n=3$$ and the associated two-dimensional statistic - $$T(\mathbf{X}) = (X_1 + X_2, X_3)$$. Is this sufficient? Yes, it is. 

$$
f_{\mathbf{X}}( \mathbf{x} \vert p) = \binom{n}{x_1 + x_2 + x_3}p^{x_1 + x_2 + x_3}(1-p)^{3 - x_1 -x_2 - x_3} \propto_p p^{x_1 + x_2}(1-p)^{2 - x_1 - x_2}p^{x_3}(1-p)^{1-x_3}
$$

which, by the Factorization Theorem, is sufficient. Good? But now, is is minimal sufficient? Intuitively, we should say no. Why? You tell me. Okay - I tell you. Consider the minimal sufficient statistic (derived above) $$X_1 + X_2 + X_3$$. This statistic takes the partitions (values) of 0,1,2, and 3. Our current statistic has, as an example, partitions (0,1) and (1,0), which are different. However, they both correspond to the *coarser* partition generated by $$X_1 + X_2 + X_3$$. So, there is always a partition of smaller cardinality. Let's show this mathematically. 

$$
\frac{f_{\mathbf{X}}(\mathbf{x} \vert p)}{f_{\mathbf{X}}( \mathbf{y} \vert p)} \propto \frac{p^{x_1 + x_2}(1-p)^{2 - x_1 - x_2}p^{x_3}(1-p)^{1-x_3}}{p^{y_1 + y_2}(1-p)^{2 - y_1 - y_2}p^{y_3}(1-p)^{1-y_3}}
$$

So, this is free of $$p$$ if $$T(\mathbf{x}) = T(\mathbf{y})$$. But, is it free of $$p$$ only if that is the case? No! If $$y_3  = x_1 + x_2$$ and $$x_3 = y_1 + y_2$$, then it is free of $$p$$ but the statistics are not equal! This is exactly what our intuition above says. If we switch the order of the ordered pair, we map to the same partition in the partition space of another statistic (namely the one defined above). So we can always define a statistic with a coarser partition (a more basic statistic that contains the same information about $$p$$). 


## More Examples 

**1**. Let $$X_1, \dots, X_n$$ but iid fraom a density function of the form: 

$$
f(x \vert \sigma) = \frac{1}{\sigma}e^{-\frac{1}{\sigma}(x - \mu)}, \; \; \mu < x, \;\; 0 < \sigma
$$

Find a one-dimensional sufficient statistic for $$\mu$$ (known $$\sigma$$), a one-dimensional sufficient statistic for $$\sigma$$ (known $$\mu$$) and a two-dimensional sufficient statistic for ($$\mu$$, $$\sigma$$)

**Answer:**

$$
f(\mathbf{x} \vert \sigma) = \displaystyle\prod_{i=1}^n \frac{1}{\sigma}e^{-\frac{1}{\sigma}(x_i - \mu)} = \sigma^{-n}e^{\frac{-1}{\sigma}(\sum x_i - n\mu)}I(x_{(1)} > \mu)
$$

$$
\sigma^{-n}e^{\frac{-\sum x_i}{\sigma}} e^{\frac{n \mu}{\sigma}}I(x_{(1)} > \mu)  = h(x)e^{\frac{n \mu}{\sigma}}I(t > \mu) = h(x)g(\mathbf{T} \vert \mu)
$$

so, by the Factorization Theorem, $$X_{(1)}$$ is a sufficent statistic for $$\mu$$. For the second part, note that the likelihood can also be written as 

$$
h(x)g(\mathbf{T} \vert \sigma)
$$

where $$h(x) = e^{\frac{n \mu}{\sigma}}I(x_{(1)} > \mu)$$  and $$g(\mathbf{T} \vert \sigma) = \sigma^{-n}e^{\frac{-t}{\sigma}}$$ where $$t = \sum_{i=1}^n x_i$$. Therefore, by the Factorization Theorem again, $$\sum_{i=1}^n X_i$$ is a sufficent statistic for $$\sigma$$. Furthermore, the likelihood can be written as 

$$
\sigma^{-n}e^{\frac{-\sum x_i}{\sigma}} e^{\frac{n \mu}{\sigma}}I(x_{(1)} > \mu) = \sigma^{-n}e^{\frac{-t_1}{\sigma}} e^{\frac{n \mu}{\sigma}}I(t_2 > \mu) = h(x)g(\mathbf{T_1},\mathbf{T_2} \vert \mu, \sigma)
$$

so, $$(\mathbf{T_2}, \mathbf{T_1}) = (X_{(1)}, \sum_{i=1}^n X_i)$$ is sufficient for $$(\mu,\sigma)$$. 

**2**. Let $$X_1, \dots, X_n \sim \mathcal{N}(0, \sigma^2)$$. 

Show that $$sum_{i=1}^n X_i^2$$ is sufficient for $$\sigma^2$$ and determine whether it is a minimal sufficient statistic or not. 

**Answer:** 

$$

f(\mathbf{x} \vert \sigma^2) = (\frac{1}{\sqrt{2 \pi \sigma^2}})^n e^{\frac{-\sum x_i^2}{2 \sigma^2}}I(\sigma^2 > 0) = (2\pi)^{-n/2}(\sigma)^{-n}e^{\frac{-\sum x_i^2}{2 \sigma^2}} 
$$

$$

= (2\pi)^{-n/2}(\sigma)^{-n}e^{\frac{-t}{2 \sigma^2}} = h(\mathbf{x})g(T(\mathbf{X}) \vert \sigma^2)

$$

where $$ t = \sum_{i=1}^n x_i^2 $$ so by the Factorization Theorem, $$T(\mathbf{X}) = \sum_{i=1}^n X_i^2$$ is sufficient for $$\sigma^2$$. Now, 

$$

\frac{f(\mathbf{x} \vert \sigma^2)}{f(\mathbf{y} \vert \sigma^2)} = e^{\frac{-1}{2\sigma^2}(\sum x_i - \sum y_i)} = e^{\frac{-1}{2\sigma^2}(T(\mathbf{x}) - T(\mathbf{y}))}

$$

If $$T(\mathbf{x}) = T(\mathbf{y})$$, this ratio is 1 which is clearly free of $$\sigma^2$$. Now, if the ratio is free of $$\sigma^2$$, then it is necessary that $$T(\mathbf{x}) = T(\mathbf{y})$$. Thus, $$T(\mathbf{x}) = \sum X_i^2$$ is a minimal sufficient statistic for $$\sigma ^2$$. 

**3**. Let $$X_1, \dots, X_n \sim \textrm{Poisson}(\lambda)$$. 

Find a sufficient statistic for $$\lambda$$ and show that it is a minimal sufficient statistic. 

**Answer:** 

$$

f(\mathbf{x} \vert \lambda) = \frac{1}{\prod_{i=1}^n x_i !}e^{-n\lambda}\lambda^{\sum x_i} = \frac{1}{\prod_{i=1}^n x_i !}e^{-n\lambda}\lambda^{t} = h(\mathbf{x})g(T(\mathbf{x}) \vert \lambda)
$$

so by the Factorization Theorem (again...), $$\sum_{i=1}^n X_i$$ is sufficient for $$\lambda$$. Now, 

$$

\frac{f(\mathbf{x} \vert \lambda)}{f(\mathbf{y} \vert \lambda)} \propto_{\lambda} \lambda^{\sum x_i - \sum y_i} = \lambda^{T(\mathbf{x}) - T(\mathbf{y})}
$$

so if $$T(\mathbf{x}) = T(\mathbf{y})$$, the ratio is free of $$\lambda$$. Furthermore, if the ratio is free of $$\lambda$$, then it is necessary that $$T(\mathbf{x}) = T(\mathbf{y})$$ for the exponent to be 0 and thus have $$\lambda$$ disappear. Therefore, $$T(\mathbf{x}) = \sum X_i$$ is also a minimal sufficient statistic for $$\lambda$$. 




