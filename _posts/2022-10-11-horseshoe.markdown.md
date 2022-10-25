---
layout: post
title:  "The Horseshoe Prior"
date:   2022-10-11 20:00:00 -0700
---

<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>


Turns out there is a lot of data in the world and, turns out, a lot of that data is not really applicable to your problem! You might just say "hey, let's throw the kitchen sink at this problem and see what comes out" (for instance, neural networks..), but sometimes you want to know what's actually on the inside (not taking sides, just saying!).  Essentially, sometimes you want to know "what is causing y?" versus "what is y?". Enter - shrinkage priors. 

In this model, there is two types of parameters that we are interested in: signal and noise. We want to knwo what parameters are having an impact on our outcome and what parameters are not. The gold standard is what is colloquially known as the spike-and-slab prior that places the prior 

$$
\beta_i \sim \pi \delta_0  + (1 - \pi)f(\beta_i ; \theta)
$$

on the parameters. With probability $$\pi$$, the prior is a point-mass centered at zero and with probabilty $$1 - \pi$$, the prior is a continuous slab distribution (usually centered at zero e.g. ($$f = N(0,\theta)$$)). 

To be continued... 