---
layout: post
title:  "Bayesian Estimation"
date:   2018-07-12 22:21:32 -0700
---

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

When most people think about statistics, they think about flipping a coin or gambling or having flashbacks to dropping out of high school because they hated the class so much... moral of the story is, it's just one thing to think about. What if I told you that that wasn't necessarily true? I am about to tell you that. Statistics is the science of modeling randomness. But what is random, and what is not? That is a fundamental question in statistics and splits the subject into two separate approaches - Bayesian and Frequentist.

What does it mean to say that I am 50% certain it will rain tomorrow? That is not so much a statement of probability, but rather of uncertainty. It will rain or it will not rain, but that outcome is something you are uncertain of. Consider another example: flip a coin and cover it up immediately once it lands, so you don't know what the result is. What're the chances that the coin is heads? From a traditional, frequentist perspective, there is no answer to this question. It already happened. There is already a result - you're just ignorant. But that's not really how we think, is it? We don't know what the result is - we are uncertain of it. Let's consider a medical example. Say you're getting screened for the flu, and the result comes out positive. Do you actually have the flu? In the frequentist approach, that doesn't make sense to ask. We do have sensitivity and specificity. Let $$ \theta = 1 $$ if you have the flu and $$ \theta = 0 $$ if you don't. Then the sensitivity is the probability the test is positive given that you have the flue, or $$ P(T = 1 \vert \theta = 1)$$ and the specificity is $$ P(T = 0 \vert \theta = 0)$$, the probability the test is negative when you don't have the flu. If specificity is not 1, you might get tested positive but not have the disease. It makes sense then to ask '"Do I actually have the flu?", but does it make statistical sense to ask 'Do I have the flu?'? That is, what is $$ P(\theta =1 \vert T = 1)$$? A frequentist says 'Bad question. $$ \theta $$ is fixed'. A Bayesian will come in and say 'Hold on, $$ \theta$$ is not actually fixed. We can estimate this' 

This is the whole premise of Bayesian statistics - to use probability theory to not *only* quantify probability but also to quantify uncertainty. Much better!! Solving problems that were disregarded earlier - we like that!

Okay, moving on... now that I've converted you to the Bayesian approach to statistics...

:)

Let's talk about the setup. In a frequentist approach, we have a random variable $$ \mathbf{X}$$, observed data from that random variable, a model, and a parameter $$ \theta \in \Omega $$ that is unknown but *fixed*. In the Bayesian framework, we don't consider that italicized part. It's a subtle change that makes a huge difference. Now, we have

$$ 
\theta \sim \pi(\theta)
$$

where $$ \pi $$ is called a *prior distribution*. Now, we need to make an adjustment to your original data's distribution. Now, we have a conditional distribution!

$$ 
\mathbf{X} \vert \theta \sim f(\mathbf{x}\vert \theta)
$$

and, by Bayes rule, the joint distribution of $$ \mathbf{X} $$ and $$ \theta $$ is

$$ 
f(\mathbf{x},\theta) = \pi(\theta)f(\mathbf{x}|\theta)
$$

and, thus, the marginal distribution of  $$  \mathbf{X} $$ is

$$ 
m(\mathbf{x}) = \displaystyle\int_{\theta \in \Omega} {f(\mathbf{x},\theta)d\theta} 
$$

$$ 
\pi(\theta \vert \mathbf{x}) = \frac{\pi(\theta)f(\mathbf{x} \vert \theta)}{m(\mathbf{x}) }
$$

We now have all the tools we need to do some basic Bayesian analysis!

and, so, by Bayes rule again, the posterior distribution of $$ \theta $$ is

Let us look at $$ X_1, \dots, X_n \sim Bernoulli(p) $$ where $$ p \sim Beta(\alpha, \beta) $$. Then we could calculate $$ \pi(\theta \vert \mathbf{x}) = \frac{\pi(p)f(\mathbf{x}\vert \theta)}{m(\mathbf{x}) } $$, but that would take forever. Does $$ m(\mathbf{x}) $$ matter? No. Why? Think about it. We want the posterior distribtion of $$ p $$, right? So $$ m(\mathbf{x}) $$ has *literally* (millenials...) nothing to do with $$ p $$, therefore it just acts as a normalizing constant in the equation to make sure that $$ \pi(p \vert \mathbf{x}) $$ is a true pdf. Therefore, we can just look at the numerator of the expression and recognize the kernel of the distribution to understand what family the posterior distribution comes from. Soo, in math,

$$ 
\pi(p \vert \mathbf{x}) \propto \pi(p)f(\mathbf{x} \vert p)
$$

We know

$$ 
f(\mathbf{x}\vert p) = \displaystyle \prod_{i=1}^{n} f(\mathbf{x_i}\vert p) = \displaystyle \prod_{i=1}^{n} (p^{x_i}(1 - p)^{1-x_i})
$$

and

$$ 
\pi(p) = \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha) \Gamma(\beta)} p^{\alpha -1}(1 - p)^{\beta -1}
$$

so

$$ 
\pi(p \vert \mathbf{x}) \propto\displaystyle \prod_{i=1}^{n} (p^{x_i}(1 - p)^{1-x_i}) \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha) \Gamma(\beta)} p^{\alpha -1}(1 - p)^{\beta -1}
$$

$$ 
= p^{\sum_{i=1}^{n}x_i}(1-p)^{n - \sum_{i=1}^{n}x_i}\frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha) \Gamma(\beta)} p^{\alpha -1}(1 - p)^{\beta -1}
$$

which is the same as

$$ 
\frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha) \Gamma(\beta)} p^{\alpha + \sum_{i=1}^{n}x_i -1} (1 - p)^{\beta +n - \sum_{i=1}^{n}x_i - 1}
$$

Looking at the part of this expression that has to do with $$ p$$, what do we see? It is the kernel of a Beta distribution! So, now we know that $$ \pi(p
\vert \mathbf{x}) \sim Beta(\alpha + \sum_{i=1}^{n}x_i, n + \beta - \sum_{i=1}^{n}x_i)$$. Cool. Another thing to notice here: the prior and the posterior distribution are from the same family. This, informally, is what you call a **conjugate family**.  Anyways, now that we have the prior distribution, we can do some estimation.

If we remember, one of the frequentist approaches to estimation is Maximum Likelihood. Here, our parameter follows a distribution so it makes sense to just say 'hey... what's its expected value?' . So that's what people do! The Bayes estimator is literally just $$ E[p\vert \mathbf{x}]$$. We know $$ \pi(p \vert \mathbf{x}) \sim Beta(\alpha + \sum_{i=1}^{n}x_i, n + \beta - \sum_{i=1}^{n}x_i)$$ . Since we know the expected value of $$ Beta(\alpha,\beta)$$ is $$ \frac{\alpha}{\alpha + \beta}$$, it follows that

$$ 
E[p \vert \mathbf{x}] = \frac{\alpha + \sum_{i=1}^{n}x_i}{\alpha + \sum_{i=1}^{n}x_i + \beta + n - \sum_{i=1}^{n}x_i} = \frac{\alpha + \sum_{i=1}^{n}x_i}{\alpha + \beta + n}
$$

$$ 
= \bar{X}(\frac{n}{\alpha + \beta + n}) + \frac{\alpha}{\alpha + \beta}(\frac{\alpha + \beta }{\alpha + \beta + n})
$$

So the Bayes estimator is just a weighted average of the prior mean and the MLE! When n is large, the MLE is weighted much more and, when n is small, we trust the prior distribution's estimate. This is a very cool result, in my opinion.

Let's look at another example. Let $$ X_1, \dots , X_n \vert \lambda \sim Poisson(\lambda)$$ and let $$ \pi(\lambda) \sim Gamma(\alpha, \beta)$$. Then

$$ 
\pi(\lambda \vert \mathbf{x}) \propto f(\mathbf{x}\vert \lambda )\pi(\lambda)
$$

$$ 
= \frac{\lambda^{\sum_{i=1}^{n}x_i} e^{-n\lambda}}{\prod_{i=1}^{n}x_i !} \frac{1}{\Gamma(\alpha)\beta^{\alpha}} \lambda^{\alpha-1}e^{\frac{-\lambda}{\beta}}
$$

$$ 
= \frac{1}{\prod_{i=1}^{n}x_i! \, \Gamma(\alpha)\beta^{\alpha}} \lambda^{\sum_{i=1}^{n}x_i +\alpha -1} e^{-\lambda(n + \frac{1}{\beta})}
$$

and we should recognize the kernel (part with $$ \lambda$$) of this distribution and conclude that

$$ 
\pi(\lambda\vert \mathbf{x}) \sim Gamma(\sum_{i=1}^{n}x_i + \alpha , (n + \frac{1}{\beta})^{-1})
$$

Another conjugate family! The Bayes estimator here is just

$$ 
E[ \lambda | \mathbf{x}] = \frac{\sum_{i=1}^{n}x_i + \alpha }{n + \frac{1}{\beta}}
$$

$$ 
= \bar{X} (\frac{n}{n + \frac{1}{\beta}}) + \alpha \beta (\frac{1}{n\beta + 1})
$$

In summary, its quite simple to find the posterior distribution in these cases - but this is obviously not true in general. Sometimes the posterior takes an unknown form, and the best we can do is draw samples from this posterior using different methods (Gibbs Sampling, Importance Sampling). These examples above are cases where the posterior follows almost immediately from the joint distribution (conjugate family in both cases, actually) and makes our lives very easy. There is much more to go into about Bayesian Estimation, and I will do so here in the future. For now, you've got a good start on it!