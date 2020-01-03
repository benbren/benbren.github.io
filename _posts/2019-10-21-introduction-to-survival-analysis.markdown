---
layout: post
title:  "Introduction to Survival Analysis"
date:   2019-10-21 20:00:00 -0700
---
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>


Survival Analysis: the branch of statistics that pretty much everyone I know only associates with biostatistics. I get it - that makes sense. Sure, survival implies.. surviving, but lots of things survive. My attempt to be a vegetarian (still going) is something that 'survives'. Your T.V., your willingness to stay on an email list. Things like that. Survival analysis takes on many different names (for instance, reliability in engineering). Essentially, it deals with data that has 'failure' times and 'censoring' times - so it takes into account actual and observational failure times. For example, a failure time could be death (actual failure) and a censoring time could be a patient lost to follow-up (observational failure). It's a cool subject - one that is applicable to almost every field, so let's dive into some of the basics. The first : $$ T$$. Big one. The time to event, which is a random variable. The second: $$ C$$. Also a big one, the time to censoring. And finally, the first and second combined into the third(?): $$ X = min(T,C)$$ which is the event we actually observe. Ok, now actually finally, we have $$ \Delta = I(T \leq C) = I (X = T)$$, which is just 1 if we observe the event and 0 if we lose the observation to censoring. Those are the big variables for the introduction, so let's get into talking about the main functions and some examples. 

There are 3 main functions in survival analysis, and all can be derived from one another. We have the survival function, the hazard function (or hazard rate, or just hazard) and the cumulative hazard function. Starting with the survival function: 

$$ S(t) = P(T >t)$$ if t is continuos and $$ S(t _ j)= P(T > t _ j) = P(T \geq t_{j-1} )$$ when t is discrete. How do we define this? We need to define a density first. 

$$ 
f_ T(t) = \lim_{\delta\to 0^+}\frac{1}{\delta}P(t  \leq T \leq t + \delta)
$$

when  $latex T$ is continuous and, simply, 

$$ 
f_T(t) = P(T = t)
$$

when $$ T $$ is discrete. Now, to define our survival function should be relatively easy. 

$$ S(t) = P(T  > t) = \displaystyle\int_ {t}^{\infty}f_T(u)du $$ when $$ T$$ is continuous 

$$ S(t) = P(T >t) = \displaystyle\sum_ {n > t}f_T(t) $$ when $$ T$$ is discrete. 

A few things to note about a survival function. $$ S(0) = 1$$ as we should not have events happening at time 0. $$ \lim_ {t\to \infty}S(t) = 0$$ as we expect everyone to die or have an event as time goes on. Also, the survival function should be monotone decreasing in $$ t$$. It is important to note that, in the discrete case, the survival function is right continuous. That is, it has jumps (down) at the values of $$ t$$ where events happen, and is evaluated and the lower probability of survival for those time periods. More formally $$S(t) = \lim_{x\to t^+}S(x) = S(t^+)$$ This is important when we are estimating... the hazard function! The hazard function is the probability that a person dies at time $$ t$$ GIVEN that they have survived until time $$ t$$. Let $$ \lambda (t)$$ denote the survival time.

$$
\lambda(t) = \lim_{\delta \to 0^+}\frac{1}{\delta}P(t \leq T \leq t + \delta  \vert T > t)
$$

when $$ T$$ is continuous and 

$$
\lambda(t) = P(T = t \vert T \geq t)
$$

when $$ T$$ is discrete. In general, from the basic probability theory, 

$$ 
P(T =t \vert T \geq t) = \frac{P(T = t, T \geq t)}{P(T \geq t)} = \frac{P(T = t)}{P(T \geq t)} = \frac{f_T(t)}{S(t^-)}
$$

Notice that the hazard function, when continuous, is a rate and, when discrete, is a probability. Finally, let us define $$ \Lambda(t)$$ as the cumulative hazard function. It is pretty much exactly what you would think it was... 

$$ 
\Lambda(t) = \displaystyle\int_{0}^{t}\lambda(u)du
$$ 

when continuous and 

$$
\Lambda(t) = \displaystyle\sum_{t_i \leq t} \lambda(t_i) 
$$

when discrete. Let's take a look at an interesting problem involving the cumulative hazard function. Say $$ T$$ follows some distribution with cdf $$ F_t(t)$$. Then its hazard function follows an exponential(1) distribution. To see this

$$ 
P(\Lambda(T) \leq t) = P( - \Lambda(T)\geq -t ) = P(e^{-\Lambda(T)} \geq e^{-t}) = 
$$

$$
P(-e^{-\Lambda(T)} \leq -e^{-t}) = P(1 - e^{-\Lambda(T)} \leq 1 - e^{-t}) = 
$$

$$
P(1-S(T) \leq 1- e^{-t}) = P(F_ T(T) \leq 1- e^{-t}) = P(T \leq F_ T^{-1}(1- e^{-t})) = F_ T(F_T^{-1}(1- e^{-t})) = 1- e^{-t}
$$

which is the cdf of the exponential(1) distribution! Cool, huh? Anyways. 

It is clear what the link between the hazard function and the cumulative hazard function is, but now let us find the explicit link with the survival function. First (and pretty much only..), remember

$$ 
\lambda(t) = \frac{f(t)}{S(t^-)}
$$

When $$ T $$ is continuous, this is equivalent to

$$ 
\lambda(t) = \frac{f(t)}{S(t^-)} = \frac{f(t)}{S(t)} = \frac{-d\log S(t)}{dt}
$$

which means 

$$ 
\Lambda(t) = -\log(S(t)
$$

and, equivalently,

$$ 
S(t) = e^{-\Lambda(t)}
$$ 

Nice! Easy. Let's do an example. Suppose $$ T$$ is such that its survival function is 

$$ 
S(t) = \frac{64}{(t+8)^2} 
$$

This is continuous. First, a fact: 

$$
E[T] = \displaystyle\int_{0}^{\infty} S(t)dt
$$

How to prove? 

$$
E[T] = \displaystyle\int_{0}^{\infty} tf(t)dt = \displaystyle\int_{0}^{\infty}\displaystyle\int_{0}^{t}ds f(t)dt = \displaystyle\int_{0}^{\infty}\displaystyle\int_{s}^{\infty}f(t)dtds = \displaystyle\int_{0}^{\infty}1 - F(s) ds  = \displaystyle\int_{0}^{\infty}S(s)ds
$$

So, what is our expected survival time in the above case? 

$$
E[T] = 64 \displaystyle\int_{0}^{\infty} (t + 8)^{-2} = 64/8 = 8
$$

Median survival time? Clearly, that is just where

$$ 
S(t) = 0.5
$$

so 

$$
\frac{64}{(t_m +8)^2} = 0.5 \implies \sqrt(128) - 8 = t_m = 3.31
$$ 

Now, let's estimate the hazard function (and the cumulative hazard). 

$$ 
\Lambda(t) = -\log(S(t)) = 2 \log(t+8) - \log(64)
$$ 

Now, we just take the derivative with respect to $$t$$ to find $$ \lambda(t)$$

$$ 
\lambda(t) = \frac{2}{t+8} 
$$ 

The discrete case is a liiiiiiitle bit more difficult, but very important for continued study in survival analysis. In practice, unless we have literall infinite observations, we will be dealing with discrete data. Let's say $$ t$$ takes on values $$ t_ 1, \dots , t_ n$$. Also, remember (more basic probability theory) that $$ P(AB) = P(A\vert B)P(B)$$. If $$B$$ is many events, then this formula is recursive. Now, suppose $$ t_j \leq t \leq t_{j+1}$$

$$
S(t) = P(T > t) = P(T > t_j, T > T_{j-1},\dots,T > t_1) = 
$$

$$
P(T > t_j \vert T > t_{j-1})\times P(T > t_{j-1} \vert T > t_{j-1})\times \dots \times P(T > t_1)
$$ 

$$ 
= [1 - P(T \leq t_j \vert T > t_{j-1})]\times \dots \times [1 - P(T\leq t_1)]
$$

$$ 
= [1 - P(T = t_j \vert T \geq t_{j})]\times \dots \times [1 - P(T = t_1)]
$$

$$
= \displaystyle\prod_{t_i\leq t} [1 - \lambda(t_i)]
$$ 

Notice, this formula is recursive! $$ S(t_j) = [1 - \lambda(t_j)]S(t_{j-1}) $$ which doesn't really matter here but .. it makes it easier to compute if, say, you wanted to write up this algorithm to help yourself learn (maybe?).  This actually has an analogous case in the continuous case (if we remember the Taylor Expansion for $$ e^{-x}$$ LOL). To the rescue again..

$$ 
e^{-x} = \displaystyle\sum_{n = 0}^{\infty} \frac{(-x)^n}{n!} \approx 1- x
$$

when $$ x $$ is small.

So, since 
$$ 
\Lambda(T) = \int_{0}^{t}\lambda(u)du
$$

and

$$ 
S(t) = e^{-\Lambda(t)}
$$

then 

$$
S(t) = \displaystyle\prod_{u=0}^t e^{-\lambda(u)du} \approx \displaystyle\prod_{u=0}^t[1 - \lambda(u)du]
$$ 

which is sometimes referred to as the product limit form of the survival function. Anyways.. let's get to some real examples. First, from data.. let's think of a good way to estimate $$\lambda(t)$$. Seems natural to estimate the hazard at a certain time point by looking at the number of events at a time point relative to the number of people at risk for the event at that time point. So, letting $$ D_ J$$ denote the number of events at time $$t_ j$$ and $$ Y _ j$$ denote the number at risk (sill being observed, including the people who experience events) for an event at $$ t_j$$. Then a natural estimate for $$ \lambda(t_j)$$ is $$ \frac{D_j}{Y_j}$$. Looking at some data (+ indicates a censored observation)... 

$$ 
2,5^+,8,12^+,15,21^+,25,29,30^+,34
$$

Let's estimate $$ S(10) $$. Notice, the first term of this estimation will be $$ P(T > 10 \vert T > 8)$$ which is 1, since nothing happens at 10.. so if someone survives past 8, they will survive past 10. For sure. With probability 1. :) SO, 

$$
S(10) = S(8) =  \displaystyle\prod_{t \in \{2,5,8\}}[1 - \lambda(t)]
$$ 

$$
= [1- \frac{D_8}{Y_8}][1- \frac{D_5}{Y_5}][1- \frac{D_2}{Y_2}]
$$ 

$$
= [1- \frac{1}{8}][1- \frac{0}{9}][1- \frac{1}{10}] = \frac{63}{80}
$$

Notice at 5, the observation was censored, so it does not get included in $$ D_5$$.

Not that this estimate of our survival function will be piece-wise continuous, right continuous with jumps at event times, and will be 0 IF our last observation is a failure. Why can we do this when we have censored data? Because we assume that $$T$$ is independent of $$ C$$, or else we would have a joint distribution for the hazard. Anyways... this type of estimation is what is referred to as the Kaplan-Meier estimate of the survival function which, along with Nelson-Aalen, is the most popular non-parametric way (or just in general) way to estimate the survival function. 

