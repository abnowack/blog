Title: L1 Regression
Date: December 6, 2016

_Notes taken from Parameter Estimation and Inverse Problems (2013) by Aster et. al, Chapter 2_.

Least squares solutions, which minimize the $L_2$ norm, are highly susceptible to observations which are inconsistent with the rest of the data set. These __outliers__ can heavily alter the model estimation. While having outliers can indicate that the model is inaccurate, in real measurements often data is not distributed normally and mismeasurements may have also occurred. 

If a measurement is 5 or more standard deviations from it's expected value, it has a one in one million chance of occurring. If a mismeasurement throws a single data point off by 5 standard deviations an $L_2$ minimizing solution will compensate heavily for it.

An alternative is to minimize the $L_1$ norm of the residual vector
$$
m_{L_1} = \text{min} \sum_{i=1}^m \frac{| d_i - (G~m)_i |}{\sigma_i} = ||d_w G_w ~ m||_1
$$

The $L_1$ norm does not square the residuals which makes it more robust against outliers. The $m_{L_1}$ solution also has a maximum likelihood interpretation; it is the maximum likelihood estimator for data distributed by a double-sided exponential distribution
$$
f(d_i | m) = \frac{1}{\sigma_i \sqrt{2}} e^{-\sqrt{2} |d_i - (G~m)_i| / \sigma_i}
$$
Even though the distribution is unusual, it remains useful to use if the presence of outliers do not change our assumption that the underlying model is correct.

Average vs Median
-----------------

As a simple exercise on the $L_2$ vs $L_1$ norm consider the most basic model, estimating a single value given some measurements of that value. In the setup $G~m = d$, $G$ is a column vector of 1, $m$ is the true value, $d$ is a column vector of the measurements.

The $L_2$ mimizing solution is found easily
$$
m_{L_2} = (G^T G)^{-1} G^T d = (\sum_{i=1}^m 1)^{-1} \sum_{i=1}^m d_i = m^{-1} \sum_{i=1}^m d_i
$$
which is simply the average of $d$.

For finding the $L_1$ minimizing solution we need to minimize the following
$$
f(m) = ||d G ~ m||_1 = \sum_{i=1}^k |d G ~ m| 
$$
This can be done by solving $f'(m) = 0$ is $f(m)$ is differentiable, unfortunately it is not differentiable at each point where $(G~m)_i = d_i$. However since $f(m)$ is convex a local minimum is also a global minimum. Instead try to minimize $f(m)$ at every point where $f'(m)$ is defined, and treat locations where it is undefined separately.

Where $f'(m)$ is defined, it is
$$
f'(m) = \sum_{i=1}^m \text{sgn}~(d_i - m)
$$

Where $\text{sgn}$ is the signum function, -1 if the argument is negative, +1 if it is positive, and 0 for an argument of 0. The function $f'(m)$ is minimized when half of the data points are above $m$ and half are below. In the case of an odd number of data points, $f'(m)$ is zero when $m$ is equal to the _median_. For an even number of points, any value of $m$ between the two middle observations is a solution.

Iteratively Reweighted Least Squares
------------------------------------

For finding $m_{L_1}$ solutions in general, there is no analytic solution like there exists for $m_{L_2}$. However _iterative_ solutions do exist which can find $m_{L_1}$ easily and mostly straight forward.

We wish to minimize the $L1$ norm of the residual vector $r = d - G~m$
$$
f(m) = ||r||_1 = \sum_{i=1}^m |r_i|
$$

Again $f(m)$ is not differentiable where any element of $r$ is zero. However if we consider all other points, it can be differentiated
$$
\frac{\partial f(m)}{\partial m_k} = \sum_{i=1}{m} \frac{\partial |r_i|}{\partial m_k} = - \sum_{i=1}{m} G_{i,k} \text{sgn} (r_i) = - \sum_{i=1}^m G_{i,k} \frac{1}{|r_i|} r_i
$$

By writing the coeffecient between $G_{i,k}$ and $r_i$ as a diagonal matrix $R$ with elements
$$
R_{i,i} = 1 / |r_i|
$$
the total derivative, the gradient, can be written in matrix form
$$
\nabla f(m) = -G^T R r = -G^T R (d - G m)
$$

Solving the minimization problem $\nabla f(m) = 0$,
$$
G^T R (d - G m) = 0 \\
G^T R G m = G^T R d
$$

Since $R$ is a non-linear function of $m$, we cannot solve for $m$ directly. Instead an iterative method is applied.

Start with the least squares solution $m^0 = m_{L_2}$ and calculate the residual vector $r^0 = d - G m^0$

Then solve for the new $m^1$ estimate using $m^0$ for the $R$ matrix
$$
m^1 = (G^T R G)^{-1} G^T R d
$$
and calculate a new residual vector and repeat. If any element of $R$ becomes zero the process fails. To overcome this, set a lower limit $\epsilon$ such that if $|r_i| < \epsilon$, then $R_{i,i} = 1 / \epsilon$.

The number of iterations can be controlled using a tolerance variable $\tau$ and iteration terminates when
$$
\frac{|| m^{k+1} - m^k ||_2}{1 + ||m^{k+1}||_2} < \tau
$$