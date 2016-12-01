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
G(m_1 + m_2) = G(m_1) + G(m_2) \quad G(\alpha m) = \alpha G(m)
$$

