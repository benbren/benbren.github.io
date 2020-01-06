---
layout: post
title:  "Linear Regression"
date:   2018-03-10 20:00:00 -0700
---

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

Linear Regression... the bread and butter of applied statistics.

At one point or another, you have encountered linear regression. Did you read a statistic in the paper this morning? Was that statistic not a percent? Does anybody read the paper anymore?... Anyways, that number was probably derived via running a regression.

A linear regression is used to describe an association (NOT A CAUSAL THING) between one (continuous) response variable, $$ Y$$ and a vector of (continuous or not, whatever) explanatory variables $$ \mathbf{X}$$. Why is it called linear regression? Well, remember from algebra that a line can be described by

$$ 
y = mx + b
$$

where $$x$$ is the independent (explanatory) variable and $$ y$$ is the dependent (response) variable. We assume there is a number $$ m$$, the slope, that describes the relationship here. Essentially, we are saying the same thing with linear regression. We want to find the best $$ \beta_ 0$$ and $$ \beta_1 $$ such that the formula

$$ 
Y_i = \beta_0 + \beta_1*X_i + \epsilon_i
$$

is the best fit given our data. It doesn't matter if $$X$$ is linear, quadratic, exponential.. only that the relationship is linear in the $$ \beta $$ parameters. $$ \epsilon $$ is an error term for every $$ i $$  observation. So the problem is really trying to find $$ \beta_0 $$ and $$ \beta_1$$ such that $$ \epsilon$$ is minimum overall, i.e. taking into account each observation. The math behind linear regression is all about how we best do that. For this post, we will only explore simple linear regression where we have one explanatory variable. This need not need be the case, and we will cover that another time - but it involves some linear algebra and is a little more involved. The rest of this post assumes some knowledge of statistics, just at a basic level like expected values and distributions.

So, we have this model

$$ 
Y_i = \beta_0 + \beta_1*X_i + \epsilon_i
$$

where $$ Y_i $$ is the response variable, $$ \beta_0 $$ is the intercept (fixed), $$ \beta_1 $$ is the slope (fixed), $$ X_i$$ is a covariate (fixed) and $$ \epsilon $$ is the error term, which is random and unobservable. As always, we need some assumptions in order to make this workable.. We assume that the errors are normally distributed and unrelated... that is,

1. $$ \epsilon_i \sim N(0,\sigma^2) $$
2. $$ E[\epsilon_i\epsilon_j] = 0 $$

These assumptions lead us to some key implicit assumptions of linear regression. *Linearity*,  *constant variance*, *independence* and *normally distributed*. That is,

1. $$ E[Y_i \vert X_i ] = \beta_0 + \beta_1X_i $$
2. $$ \sigma_i^2 =  V[Y_i \vert X_i] = \sigma^2 $$
3. $$ Y_i \perp Y_j, i \neq j $$
4. $$ Y_i \sim N(\beta_0 + \beta_1X_i,\sigma^2) $$

We treat the covariates as fixed, but sometimes they aren't.  For instance, there could be measurement error in the covariates. Really, the goal is to keep that randomness small.

Let's talk about $$ \beta_0 $$ and $$ \beta_1 $$. How should we interpret them? Well, they are part of a linear relationship. We are  going to estimate them such that we fit a line to the data that should give us the expected value of the response given some input parameters.  That is,

$$ 
E[ Y_i | X_i ] = \hat{\beta_0} + \hat{\beta_1}X_i
$$

The little hat things mean they are estimated, not the true parameters... more on that later. So, $$ \hat{\beta_0} $$ is the average value of $$ Y $$  when $$ X = 0 $$. Furthermore, $$ \hat{\beta_1} $$ is the average change in $$ Y $$ for a unit increase in $$ X $$. In general, it is best to not extrapolate beyond what your limits for $$ X $$ are. If your covariate is age, and you only have observations for people aged 15 - 30, don't make the assumption that the model works for a 90-year-old... please.

Okay! Now to the fun stuff... math. We wanna estimate the parameters here. How do we do that? Calculus. :)

First, we need to define best. What is the *best* fit? That's arbitrary, as there are many ways to do this. We are going to do it via ordinary least squares, or OLS, which is the default way that any linear regression is fit. What this means is that we want to minimize the **Sum of Squared Errors (SSE)**, or, in math,

$$ 
\sum_{i=1}^{n} \hat{\epsilon_i}^2
$$

So, we need a definition of $$ \hat{\epsilon_i} $$, Well, it is just $$ Y_i - \hat{Y_i} $$ or, even better, $$ Y_i - (\hat{\beta_0} + \hat{\beta_1}X_i) $$ , since that is how we are guessing our reponse variable. This is good because now we have written $$ \hat{\epsilon_i} $$ as a function of $$ \hat{\beta_0} $$ and $$ \hat{\beta_1} $$, which are our tuneable parameters. Now we will need a little bit of calculus. This function will reach a critical value when

$$ 
\textbf{\(*\)} \frac{\partial SSE}{\partial \beta_0} = 0
$$

and 

$$
\textbf{\(**\)} \frac{\partial SSE}{\partial \beta_1} = 0
$$

Remember? ;)

Let's solve (*) first.

$$ 
\frac{\partial SSE}{\partial \beta_0} = 0 
$$

$$ 
\implies -2 \sum_{i=1}^{n}(Y_i - \hat{\beta_0} -\hat{\beta_1}X_i) = 0 
$$

$$ 
\implies \sum_{i=1}^{n}Y_i  - \hat{\beta_1}\sum_{i=1}^{n}X_i= n\hat{\beta_0}
$$

$$ 
\implies \hat{\beta_0} = \bar{Y} - \hat{\beta_1}\bar{X}
$$

So, if we know $$ \hat{\beta_1} $$, we can estimate $$ \hat{\beta_0} $$ . Now, looking at (**) and subbing in this result,

$$ 
\frac{\partial SSE}{\partial \beta_1} = 0 
$$

$$
\implies -2 \sum_{i=1}^{n}X_i (Y_i - \hat{\beta_0} -\hat{\beta_1}X_i) = 0
$$

$$
\implies -2 \sum_{i=1}^{n}X_i (Y_i -\bar{Y} +\hat{\beta_1}\bar{X} -\hat{\beta_1}X_i) = 0
$$

$$ 
\implies \sum_{i=1}^{n}X_i(Y_i - \bar{Y}) = \hat{\beta_1} \sum_{i=1}^{n}X_i(X_i - \bar{X})
$$

$$ 
\implies \hat{\beta_1} = \frac{SSXY}{SSX}
$$

where $$ SSXY = \sum_{i=1}^{n}X_i(Y_i - \bar{Y})$$ and $$ SSX =  \sum_{i=1}^{n}X_i(X_i - \bar{X})$$

{% highlight r %}

data(mtcars)
names(mtcars)
str(mtcars)	
{%endhighlight%}


