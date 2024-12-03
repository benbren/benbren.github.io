---
layout: post
title:  "The Horseshoe Prior"
date:   2022-10-11 20:00:00 -0700
---

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>


Turns out there is a lot of data in the world and, turns out, a lot of that data is not really applicable to your problem! You might just say "hey, let's throw the kitchen sink at this problem and see what comes out" (for instance, neural networks..), but sometimes you want to know what's actually on the inside (not taking sides, just saying!).  Essentially, sometimes you want to know "what is causing y?" versus "what is y?". Enter - shrinkage priors. 

In this model, there is two types of parameters that we are interested in: signal and noise. We want to knwo what parameters are having an impact on our outcome and what parameters are not. The gold standard is what is colloquially known as the spike-and-slab prior (or a discrete mixture) that places the prior 

$$
\beta_i \sim \pi \delta_0  + (1 - \pi)f(\beta_i ; \theta)
$$

on the parameters. With probability $$\pi$$, the prior is a point-mass centered at zero and with probabilty $$1 - \pi$$, the prior is a continuous slab distribution, usually centered at zero (e.g. $$f = N(0,\theta)$$). That is, we assume there is a non-zero possibility that the parameters have some deviation from 0 and hence are signals, and we can actually analyze that probability with $$\pi$$.  Logically, the the discrete mixture model makes sense - there is a positive prior probability that the parameters are exactly zero. Computationally, the discrete mixture model can be quite intensize as the solution set grows quickly ($$2^n$$) as well as the marginal likelihoods $$p(\beta_j ; \mathrm{data}) $$ being quite difficult to calculate. 

To be continued... 