---
layout: post
title:  Sufficient Statistics 
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

Anyways. Let's define what a sufficient statistic is. A statistic $$T(\mathbf{X})$$ is called a *sufficient statistic* for the parameter $$\theta$$ if the distribution of the data $$\mathbf{X}$$ given $$T(\mathbf{X})$$ does not depend on $$\theta$$. Why? This means that, given that we know the value of $$T(\mathbf{X})$$, the information left in the sample does not contain any information about $$\theta$$. This should be obvious - if the distribution of the data does not depend on the parameter, how can you get information about the parameter from that distribution ya know? Formally, if 

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

so $$h(\mathbf{x}) = \left(\frac{1}{\sqrt{2\pi\sigma^2}}\right) ^n \textrm{exp}\left( - \sum x_i^2 \right)$$ and $$g(t \vert \mu) = \textrm{exp}\left( n(2 \mu \bar{x} - \mu) \right)$$ when $$t = \bar{x}$$, so the sample mean is sufficient for $$\mu$$.