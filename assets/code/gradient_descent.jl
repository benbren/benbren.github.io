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
