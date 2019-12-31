---
layout: post
title:  "Gradient Descent"
date:   2019-12-30 22:21:32 -0700
categories: jekyll update
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

Jekyll requires blog post files to be named according to the following format:

`YEAR-MONTH-DAY-title.MARKUP`

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers, and `MARKUP` is the file extension representing the format used in the file. After that, include the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

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

        gradient = α * (X' * error)
        β = β - gradient

        e = norm(gradient)

        it = it + 1
    end

    return β, e
end 
{% endhighlight %}


Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
