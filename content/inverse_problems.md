Title: Notes on Inverse Problems
Date: December 1, 2016

Overview
--------

Given a set of __observational data__ $d$ deriving from physical parameters compromising a __model__ $m$, the relation between them can be written as

$$
G(m) = d
$$

Where $G$ is an __operator__ and includes the relation between $m$ and $d$ based on physics. This relation where  $d$ is generated from $G$ and $m$ is the __forward problem__. It can be complicated if $d$ also includes a noise component $\eta$.

$$
d = G(m_\text{true}) + \eta = d_\text{true} + \eta
$$

Conversely the task of finding the model $m$ from a set of data $d$ is the __inverse problem__. This can either be deriving some physical quantities such as density or material properties, or coefficients in a functional representation of $m$. We task may either be a __discrete inverse problem__ or a __continuous inverse problem__ depending on whether the model and data are data vectors or functions of continuous variables.

Linear Systems
--------------

A common class of operators are __linear systems__ which obey superposition and scaling laws

$$
G(m_1 + m_2) = G(m_1) + G(m_2) \\
G(\alpha m) = \alpha ~ G(m)
$$

For linear discrete inverse problems $G$ can be represented as a matrix
$$
G(m) = G~m = d
$$

And in continuous problems as a kernel $g(x, \xi)$
$$
G(m) = \int_b^a g(x, \xi) ~ m(\xi) ~ d\xi = d(x)
$$
The continuous representation where $m(x)$ is unknown are called __Fredholm intergral equations of the first kind (IFK)__.

It can also be written as a convolution equation
$$
\int_{-\infty}^\infty g(x-\xi) ~ m(\xi) ~ d\xi = d(x)
$$
Where determining $d(x)$ is the forward problem, and finding $m(x)$ is the inverse problem.

Why Inverse Problems Are Hard
-----------------------------
* __Existence__: There may be no model $m$ which fits the data $d$ exactly. Either because the physics $G$ are approximate or the data contains noise.
* __Uniqueness__: There may be multiple models $m$ which satisfy $G(m) = d$, even an infinite number may exist. This occurs if $G$ has a non-trivial nullspace. That is the existence of non-zero $m_0$ such that $G(m_0) = 0$. 
* __Instability__: Calculating $m$ may be extremely sensitive to changes in $d$. This is referred to as an ill-posed or ill-conditioned problem. Additional constraints must be placed on $m$ for a stable solution, a process known as __regularization__.