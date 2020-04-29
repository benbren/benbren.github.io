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

First - and back to the beginning - what is a statistic?! (FYI - this is less of a post, more of a literal book chapter.. fair warning!) 

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

Is a minimal sufficient statistic unique? **No**. This is the first fact. It turns out that any injective function of $$T(\mathbf{X})$$ is also a minimal sufficient statistic. Why does this make sense? Intuitively, a one to one function of $$T(\mathbf{X})$$ maps the partitions created by $$T(\mathbf{X})$$ uniquely to partitions in a different partitioned space. Since $$T(\mathbf{X})$$ is a minimal sufficient statistic, it achieves the coarsest possible partition space (i.e with the smallest cardinality), so the mapping of a function of $$T(\mathbf{X})$$ has to map to the smallest number of possible partitions, by default. 

A more formal proof is as follows. To understand why this proof is as follows, remember that *only* a 1-1 function has an inverse: 

**Proof**: 

Let $$T^*(\mathbf{X}) = b(T(\mathbf{X}))$$ be a one-to-one function. Then, $$\exists \; b^{-1}$$ such that $$b^{-1}(T^*(\mathbf{X})) = T(\mathbf{X})$$. Thus, knowing $$T^*(\mathbf{X})$$ assures that we know $$T(\mathbf{X})$$ via $$b^{-1}(.)$$. We can also see that, by the factorization theorem, when $$T$$ is sufficient, $$\exists \; h, \; g$$ such that $$ f(\mathbf{x} \vert \theta) = g(T(\mathbf{x}) \vert \theta)h(\mathbf{x}) = g(b^{-1}(T^*(\mathbf{X}))\vert \theta)h(\mathbf{x})$$. Thus, $$T^*(\mathbf{X})$$ is sufficient for $$\theta$$. This shows that $$T^*(\mathbf{X})$$ is a sufficient by the Factorization Theorem. Now, assume there is another sufficient statistic $$T_1(\mathbf{X})$$. Since $$T$$ (the original one) is minimal sufficient, then $$T = q(T_1(\mathbf{X}))$$. Therefore, $$T^* = b(T) = b(q(T_1))$$. Therefore, $$T^*(\mathbf{X})$$ is a function of any other sufficient statistic, and is thus a minimal sufficient statistic.

This fact actually leads us to the next fact - there is *always* a one-to-one function between two minimally sufficient statistics. To show this, suppose there are two minimally sufficient statistics $$\mathbf{T_1}, 
\mathbf{T_2}$$. Then, $$\mathbf{T_1} = f(\mathbf{T_2})$$ and $$\mathbf{T_2} = g(\mathbf{T_1})$$. Thus, $$\mathbf{T_1} =f(g(\mathbf{T_1}))$$ which implies that $$ f= g^{-1}$$ and therefore $$f$$ is one-to-one. The same can be shown for $$g$$. What this means practically is that the partition created by a minimal sufficient statistic is unique.  

And... now some totally non-boring to examples, so you can pass your class. ;).

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

### Ancillary Statistics 

Now - we will talk about ancillary statistics. This mean seem like it is out of left field, and it is, but it is still a pretty basic part of inference (and a type of statistic) so we are going to cover it. 

First, lets talk about the word ancillary. The first time I heard this word, actually, was from a professor I had who was from India and had learned English with a British accent, so I now say ancillary ancíllary, not ancilláry. Anyways - to the point. 

A statistic is ancillary if its distribution does not depend on the parameter $$\theta$$. 

How is this different from a sufficient statistic? At first glance, the definitions seem kind've similiar. They aren't at all. A sufficient statistic is a statistic that contains all the relevant information about $$\theta$$ in the data. An ancillary statistic, by defintion, do not contain any information about the parameter at all. I know what you are thinking - so, if they contain no information about the parameter, why in the *world* should I care about these things? We will get back to that point.

First, some examples. Let $$X_1, \dots,X_n \sim \mathcal{N}(\mu,\sigma^2)$$ where $$\sigma^2$$ is known. Consider $$T_1 = X_1 - \mu$$. This is not, because the statistic is a function of the parameter $$\mu$$. What about $$T_2 = X_1 - X_2$$? Yes. Since both are Gaussian, the distribution of $$T_2$$ is Gaussian with expected value 0 and variance $$2\sigma^2$$, by convolusion. Therefore, the distribution of $$T_2$$ does not depend on $$\mu$$ and thus is ancillary. Also, remember $$\frac{(n-1)s^2}{\sigma^2} \sim \chi_{n-1}^2$$. So, the sample standard deviation is also an ancillary statistic for $$\mu$$! These are some realtively simple examples, and ones that maybe we should have known off the top of our heads (just an assumption, since you are reading this). How about we look at something a bit more difficult? 

What if we have $$X_1, \dots, X_n \sim \mathcal{N}(0,\sigma^2)$$ and we define Y_i to be $$ X_i \sigma$$. Then, while is not ancillary because it is a function of $$\sigma^2$$, it does follow a standard normal distribution now. Therefore, we can show that $$\frac{X_1}{X_2} = \frac{\sigma Y_1}{\sigma Y_2} = \frac{Y_1}{Y_2}$$ which, from ratio distributions, is distributed Cauchy. So, by using that transform, we have found a way to use the original data to create an ancillary statistic. Notice, actually, that any function of $$\mathbf{Y}$$ does not depend on $$\sigma^2$$ at all, so constructing ancillary statistics is not hard at all, in this case.  Now let's look at a much more difficult problem.

Let $$X_1, \dots , X_n \sim \textrm{Uniform}(\theta, \theta +1)$$. Show that the range, $$R = X_{(n)} - X_{(1)}$$ is an ancillary statistic. There are two ways to do this - we can go through both. The first is to find the distribution of $$R$$ and show that it does not depend on $$\theta$$ - not trivial. To start, we need the joint distribution of the min and the max. This is given in Casella & Berger, Thm. 5.4.6. For any pair of order statistics, the joint distribution is given by

$$
f_{X_{(i)},X_{(j)}}{y_1,y_2 \vert \theta} = \frac{n!}{(i-1)!(j-1-i)!(n-j)!}f_{X}(y_1)f_{X}(y_2) \left[ F(y_1) \right]^{i-1} \left[ F(y_2) - F(y_1)\right]^{j-i-1}[1-F(y_2)]^{n-j}
$$

Therefore, the joint distrbution of the min and the max is 

$$
\frac{n!}{(n-2)!}f_X(x_{(1)})f_X(x_{(n)})[F(x_{(n)}) - F(x_{(1)})]^{n-2}
$$

Now, we use our knowledge of the uniform distribution! Note that 

$$
f_X(x \vert \theta) = I(\theta < x \ \theta + 1)
$$

and that 

$$
F_X(x \vert \theta ) = 
\begin{cases}
   0 & \;\;\textrm{if} \;\; x \leq \theta \\
   x - \theta & \;\;\textrm{if} \;\; \theta < x < \theta +1 \\
   1 & \;\;\textrm{if} \;\; x \geq \theta + 1 \\
   
\end{cases}    

$$

Therefore, the join distribution of $$X_{(1)}, X_{(n)}$$ is given by 

$$
\begin{cases}
n(n-1)(x_{(n)} - x_{(1)})^{n-2} & \;\; \textrm{if} \;\; \theta < x_{(1)} < x_{(n)} < \theta + 1 \\
0 & \;\; \textrm{else}
\end{cases}
$$

Now, we need to find the distribution of the range! To do this, let $$M = \frac{X_{(1)} + X_{(n)}}{2}$$ be the median. Then, $$X_{(1)} = \frac{2M - R}{2}$$ and $$X_{(n)} = \frac{2M+R}{2}$$. The Jacobian is then 

$$
\mathbf{J} = 
\left[\begin{matrix}
\frac{\partial X_{(1)}}{\partial R} & \frac{\partial X_{(1)}}{\partial M} \\ 
\frac{\partial X_{(n)}}{\partial R} & \frac{\partial X_{(n)}}{\partial M}
\end{matrix}\right] = 
\left[\begin{matrix}
-\frac{1}{2} & 1 \\ 
\frac{1}{2} & 1
\end{matrix}\right]
$$

and the determinant here is 1. Therfore me can just plug and chug, no need to add in $$\vert \mathbf{J} \vert$$ to our new pdf. We have the same domain restrictions, just now $$\theta < \frac{2m - r}{2} < \frac{2m + r}{2} < \theta + 1$$. If we fix $$r$$, we can see that $$\theta + r/2 < m < \theta + 1 - r/2$$ and we can see that the domain of $$r$$ is $$(0,1)$$. This is all the information we now need to know to derive the distribution of $$R$$. It follows from this that 

$$
f_R(r) = \displaystyle\int_{\theta + r/2}^{\theta + 1 - r/2} n(n-1)r^{n-2}dm = n(n-1)r^{n-2}(1-r)
$$

and this doesn't depend on $$\theta$$! So the range is ancillary. Another thing to notice here - this totally sucked to derive. I know it. You know it. We *all* know it. Lets do it a way easier way! Define $$Y =  X_i - \theta$$. Then, 

$$
f_Y(y) = I(\theta < y + \theta < \theta + 1) \vert \frac{dx}{dy}\vert = I(0 < y < 1)
$$

which is Uniform(0,1). Wow, so now $$R = X_{(n)} - X_{(1)} = (Y_{(n)} + \theta )-(Y_{(1)} + \theta) = Y_{(n)} - Y_{(1)}$$ which has nothing to do with $$\theta$$, andwe can conclude the range is ancillary. Way easier. And similar to the example above the hard example above. Kinda seems like there might be a point.. there is! 

Suppose $$\mathbf{X} \sim f(x - \theta)$$ where $$f$$ is an arbitrary distrbution. Define $$Y$$ as above. Then $$f_Y(y) = f_X{y + \theta - \theta}$$ which does not depend on $$\theta$$. So the range cancels out the $$\theta$$ as it does above, and we again get a distribution that does not depend on $$\theta$$. Seems like for siome distributions, we can just divide the random variables and get an ancillary statistic, and for other types of distributions we can just use the range. This is where the idea of a *location-scale family* comes in. 

If $$f(x)$$ is a pdf, the $$\frac{1}{\sigma}f(\frac{x - \mu}{\sigma})$$ is also a pdf, specifically a *location-scale family with standard pdf* $$f(x)$$. Here, $$\mu$$ is called the location parameter and $$\sigma$$ is called the scale parameter. For instance, $$\mathcal{N}(\mu,\sigma^2)$$ is a location-scale family with standard pdf $$\mathcal{N}(0,1)$$ and location parameter $$\mu$$ and scale parameter $$\sigma$$. 

We showed above that the range is an ancillary statistic for a location family. Now, we can show that the ratio $$X_1/X_n$$ is an ancillary statistic for an arbitrary scale family with pdf $$f(x/\sigma)/\sigma$$ with $$\sigma > 0$$.

Define $$Y = \frac{X}{\sigma}$$. Then, $$ X = \sigma Y$$ and $$dx/dy = \sigma$$. Thefore, $$f_Y(y) = \frac{1}{\sigma}f_X(\sigma y/\sigma) \sigma = f(y)$$. Then, $$\frac{X_1}{X_n} = \frac{\sigma Y_1}{\sigma Y_n} = \frac{Y_1}{Y_{n}}$$ which does not depend on $$\sigma$$. 

So its been fun learning about ancillary statistics.. but why does it matter again? Turns out that, while ancillary statistics do not contain any information about $$\theta$$, they can help up the precision in our estimation of $$\theta$$. How, do you say? Consider the Uniform($$\theta, \theta + 1$$) case, and say we know the range is 0.8. This doesn't tell us anything about $$\theta$$ *alone*. But say we also know the median is 1. If we *only* knew the median was 1, we would only know that $$0 < \theta < 1$$.  Now, by knowing the range *and* the median, we now that $$X_{(1)} = 0.6$$ and $$X_{(n)} = 1.4$$. From this information, we can gather that $$\theta$$ must be in the range of $$0.4 < \theta < 0.6$$ because it can't be more than 0.6 (or we wouldn't observe the minimum we have) and vice versa for 0.4. So, in summary, ancillary statistics, *when combined with other statistics*, can improve our understanding of the parameter. However, alone, they do nothing for us. They're like a friend's friend. Lots of fun to hang out with, but only when your mutual friend is around. Otherwise, things get awkward and you just want to go home. 

## Complete Statistics 

So lets tie all this together (not really, but lets wrap this up with final discussion about statistics). 

We will end this by talking about **complete statistics**. Sounds cool. What is it? It's actually defined through familes of distributions (like we talked about above). Let $$\mathcal{P} = \{ p(t \vert \theta), \theta \in \Theta \}$$ be a family of distributions for $$T(\mathbf{X})$$. If $$ E\left[ g(T) \vert \theta \right] = 0 \; \; \forall \; \theta \; \implies P[g(T) = 0 \vert \theta] = 1 \; \forall \; \theta$$, then $$T(\mathbf{X})$$ is called a **complete statistic**! 
Really, completeness is a property of the family of distributions. To call a statistic itself complete is almost misleading. To get some more intuition into this problem, notice that, in the discrete case, 

$$
E_{\theta}\left[ g(t) \right] = \sum_{i} g(t_i) \times P_{\theta}(T = t_i) = g(t_1) \times p_{\theta}(t_1) + \dots = 0 
$$

Therefore, for $$T$$ to be complete, this must mean that $$g(t)$$ above is almost surely 0 - i.e there is no non-trivial (occuring with probabilty 0) $$g(t)$$ that is not zero. This is analagous to the idea of linear independence of vectors. Above, we only have one.. or do we? We actually have a set of equations that corresponds to the number of $$\theta \in \Theta$$. So, we have 

$$
\vec{g(\mathbf{x})} \times \mathcal{P}_{\Theta} = 0
$$

This can only happen when either $$g(T) = 0$$ or $$\mathcal{P}$$ does not change across separate values of $$\theta$$, or if it changes very simply (i.e scaled by a constant). Therefore, completeness guarantees that distributions parameterized by different values of $$\theta$$ are distinct. If you change $$\theta$$, you change the whole thing. Also, conceptually note that there is a "no nonsense" part of this definition. It says "if $$g$$ is expected to be zero with respect to $$\theta$$, then it is just zero". That is, there is no part of the distribution of $$g$$ that does not depend on $$\theta$$. No nonsense. One thing to note from this is that, if you can make an ancillary statistic out of $$T(\mathbf{X})$$, then it cannot be complete... which follows immediately from what was stated above. Another thing to note - this is all defined by the family of distributions $$\mathcal{P}$$, that depends on the set $$\Theta$$. A statistic may be complete for a certain portion of that set, and may not be complete for another.  
Let's check out some examples. Suppose $$\mathbf{X} \sim \textrm{Uniform}(\theta,\theta + 1)$$ and $$T(\mathbf{X}) = (X_{(1)}, X_{(n)})$$. Is this a complete statistic? We should think, intuitively, that it is not. We can make an ancillary statistic (the range) out of this statistic. A complete statistic has no non-trivial part that doesn't depend on $$\theta$$, but nothing about the range depends on $$\theta$$. Let $$g(T) = R - E[R]$$. Now notice that $$E[R]$$ is a constant with respect to $$\theta$$. Therefore, $$g(T)$$ is a non-zero function, but $$E[g(T)] \; \forall \; \theta$$. Therfore, $$T$$ is not complete! 


Now suppose $$T \sim \textrm{Poisson}(\lambda), \; \lambda \in \{1,2\}$$. Now, if $$E_{\lambda=1}[g(t)] = 0$$, $$E_{\lambda=1}[g(t)] = 0$$ implies that $$\sum_{t} \frac{g(t)}{t!} = \sum_{t} \frac{g(t)2^t}{t!} =  0$$ which clearly does not mean that $$g(t)$$ must be zero, and you can think of *lots* of examples. So this family is not complete. Notice how we are talking about a family of distributions... and remember how I said it depended on the range of the parameter. Now, suppose 

$$ 
T \sim \textrm{Poisson}(\lambda), \; \; \lambda \in \mathbb{R}^+
$$

Now, suppose there is $$g$$ such that $$E[g(T)] = 0$$ for all $$\lambda$$. Then,

$$
\sum_{t = 0}^{\infty} \frac{g(t)}{t!}\lambda^t = 0 = \sum_{t = 0}^{\infty} \phi(t) \lambda^t = 0
$$

Since $$\lambda > 0$$, this can only be 0 if $$\phi(t) = 0 \; \forall \; t \; \implies \; g(t) = 0 \; \forall t$$. Bam, complete. By adding more dimensionality to $$\Omega$$, the parameter space for $$\lambda$$, we make the family complete. Why is this? Becauase the larger the family (i.e the more paramters), the more constraints $$g$$ must satisfy. At some point, the only such $$g$$ is the trivial $$g$$, 0. This means the family is complete.

Suppose $$X_1, \dots, X_n \sim \textrm{Uniform}(0,\theta)$$. Show that $$X_{(n)}$$ is complete. 

The distribution of $$T$$ is 

$$
f(t \vert \theta) = n f_X(t) \left[ F_X(t) \right] = n\frac{1}{\theta} \left[ \frac{t}{\theta} \right]^{n-1}
$$

So, assume that $$E[g(T)] = 0$$. Then, 

$$
\displaystyle\int_{0}^{\theta} g(t)\frac{n}{\theta^n}t^{n-1} = 0 \implies \displaystyle\int_{0}^{\theta} g(t)t^{n-1} = 0
$$

and, by the Fundamental Theorem of Calculus, 

$$
\displaystyle\int_{0}^{\theta} g(t)t^{n-1} = \displaystyle\int_{0}^{\theta} F(t)dt = F(\theta) - F(0) = g(\theta)\theta^{n-1} = 0
$$

so, since $$\theta > 0 \; , \; g(\theta) = 0$$ for all $$\theta > 0 $$ - concluding the $$X_{(n)}$$ is complete. 

There's just a few more things (2) to be said about complete statistics. 
1. If a function of $$T \; , \; h(T)$$ is ancillary, then $$T$$ cannot be complete. This goes with what we said before - a complete statistic does not have any unncessary part associated with it. Let $$g(T) = h(T) - E[h(T)]$$. Since $$h(T)$$ is ancillary, then $$g(T) = 0$$ for all $$\theta$$. But, again, $$g(T)$$ is non-zero. Or, at least, it doesn't have to be zero.
2. Say $$T_1(\mathbf{X})$$ is complete. Then $$h(T) = T_1$$ is also complete. So assume $$E[g(h(T))] = E[g(T_1)] = 0$$. Now, since $$T$$ is complete, $$P(g(h(T))) = P(g(T_1)) = 1$$ for all $$\theta$$.  

Great! Now, to put some things together: if a minimal sufficient statistic exists, then any complete sufficient statistic is also a minimal sufficient statistic. So, if you find a statistic that is sufficent and complete, it is also minimal sufficient (assuming a minimally sufficient statistic exists). However, a minimal sufficient statistic is not always complete. So, in summary, complete $$\implies$$ minimal! 

So, I think the main question to be answered here (outside of the questions below.. ;)) is "Why does any of this matter?". That's a great question, and an important question to ask of all the theory that you learn. I was a math major - and now a graduate student in statistics, and theory without relevance - for me - is still something I struggle with. However, there is relevance here ... moving forward, and just in general. In general, what these definitions and theorems are moving us towards is a way to best answer "so what is going on here?" when we see some data. If I gave you a set of numbers, there is a million ways you can analyze it, but some of those ways are more efficient than others. All of this is just one builiding block of inference. It is the beginning of the journey in figuring out the *best* way to look at data - and that is important. Some of these (ancillary..) are just tools to make other tools better. Some of these are ways to make our life easier when dealing with data. And some are really awkward, seemingly random definitions (looking at you, complete...) that are best understood in the context of what they can be used for in more advanced inference. So all of this "matters" mostly in the way that a staircase works - its harder to reach the second step if you don't have the first one.  

## More Examples 

**1**. Let $$X_1, \dots, X_n$$ but iid from a density function of the form: 

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

Show that $$\sum_{i=1}^n X_i^2$$ is sufficient for $$\sigma^2$$ and determine whether it is a minimal sufficient statistic or not. 

**Answer:** 

$$

f(\mathbf{x} \vert \sigma^2) = (\frac{1}{\sqrt{2 \pi \sigma^2}})^n e^{\frac{-\sum x_i^2}{2 \sigma^2}}I(\sigma^2 > 0) = (2\pi)^{-n/2}(\sigma)^{-n}e^{\frac{-\sum x_i^2}{2 \sigma^2}} 
$$

$$

= (2\pi)^{-n/2}(\sigma)^{-n}e^{\frac{-t}{2 \sigma^2}} = h(\mathbf{x})g(T(\mathbf{X}) \vert \sigma^2)

$$

where $$ t = \sum_{i=1}^n x_i^2 $$ so by the Factorization Theorem, $$T(\mathbf{X}) = \sum_{i=1}^n X_i^2$$ is sufficient for $$\sigma^2$$. Now, 

$$

\frac{f(\mathbf{x} \vert \sigma^2)}{f(\mathbf{y} \vert \sigma^2)} = e^{\frac{-1}{2\sigma^2}(\sum x_i^2 - \sum y_i^2)} = e^{\frac{-1}{2\sigma^2}(T(\mathbf{x}) - T(\mathbf{y}))}

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

**4** 

Let $$ X_1, \dots, X_n \sim f_X(x \vert \theta)$$ where 

$$
f_X(x \vert \theta) = \frac{2x}{\theta^2}, \; \; 0 < x < \theta
$$

Find a minimal sufficent statistic for $$\theta$$

**Answer:** 

$$
\frac{f_X(\mathbf{x} \vert \theta)}{f_X(\mathbf{y} \vert \theta)} = \frac{\prod x_i I(x_{(n)} > \theta)}{\prod y_i I(y_{(n)} > \theta)} \propto_{\theta} \frac{I(x_{(n)} > \theta)}{I(y_{(n)} > \theta)}
$$

Therfore, since this ratio doesn't depend on $$\theta$$ if and only if $$x_{(n)} = y_{(n)}$$, then $$X_{(n)}$$ is minmial sufficient. 

**5** 

Suppose $$X_1, \dots , X_n \sim f(x \vert \theta)$$ where

$$
f(x \vert \theta) = \theta x^{\theta - 1} \textrm{exp}(-x^{\theta})
$$ 

with $$\theta ,\; x \; > \; 0$$. Show that $$\frac{\log X_{(n)}}{\log X_{(1)}}$$ is ancillary. Well, let $$Y = \theta \log(X) \implies X = e^{Y/\theta}$$. Then, 

$$
f_Y(y) = f_X(e^{Y/\theta})\vert \frac{dx}{dy} \vert = \theta \; \textrm{exp}(\frac{y}{\theta}(\theta - 1))\textrm{exp}(-\textrm{exp}(\frac{y}{\theta}(\theta))) \frac{1}{\theta}e^{y/ \theta}
$$

$$

 = \textrm{exp}(y - e^y)
$$

Now, since $$\theta > 0$$ and $$\log(*)$$ is increasing monotonically, the maximum and minimum values are the same after the mappings. Thus, 

$$
\frac{\log X_{(n)}}{\log X_{(1)}} = \frac{Y_{(n)}}{Y_{(1)}}
$$

which is ancillary, since the distribution of $$Y$$ does not depend on $$\theta$$, as we have shown above.

**6** 

Suppose $$X_1, \dots, X_n \sim \textrm{Uniform}(-\theta, \theta)$$. Is $$T(\mathbf{X}) = (X_{(1)}, X_{(n)})$$ a complete sufficient statistic? If not, is $$\textrm{max}_i \vert X_i \vert$$?

**Answer:** 

The first question: No, and this should be easy to see. This is a scale family, so we can make an ancillary statistic out of $$\frac{X_{(n)}}{X_{(1)}}$$. Just let $$ X = \theta Y$$ and do the transform. Therefore, this statistic cannot be complete. More cleary, 

$$
f_Y(y) = f_X(\theta y) \vert \frac{d \theta y}{dy} \vert I(-\theta < y \theta < \theta) = \frac{1}{2}I(-1 < y < 1)
$$

which is Uniform(0,1). Then, let $$g(T) = \frac{X_{(n)}}{X_{(1)}} - E\left[ \frac{X_{(n)}}{X_{(1)}} \right] = \frac{Y_{(n)}}{Y_{(1)}} - E \left[ \frac{Y_{(n)}}{Y_{(1)}} \right]$$. Now we see $$E\left[ g(t) \vert \theta \right] = 0$$ for all $$\theta$$ but it doesn't mean that $$g(T) = 0$$ almost surely.  

Now, for $$Y = \textrm{max}_i \vert X_i \vert$$. Lets define the distribution first for $$\vert X \vert$$ 

$$
F_Y(y) = P(Y < y) = P(- y < X < y ) = P(X < y) - P (X < -y)
$$

$$
\implies f_y(y) = f_X(y) - f_X(-y)(-1) = f_X(y) - f_X(-y) = \frac{1}{\theta} I(0 < y < \theta)
$$

which is Uniform($$0, \theta$$). Now, we know that $$T = \textrm{max}_i \vert X_i \vert$$ is distributed with pdf 

$$
f_T(t \vert \theta) = nf(X)[F(x)]^{n-1}
$$

and now this is the exact problem we did in the examples above. So this is a complete statistic! Is it sufficient? 

$$
f_X(x \vert \theta) = \left[ \frac{1}{2 \theta}\right]^n I(-\theta < \mathbf{x} < \theta) = \left[ \frac{1}{2 \theta}\right]^n I(t < \theta)
$$

so it is sufficient by the factorization theorem! Therefore, this is a complete sufficient statistic. 





