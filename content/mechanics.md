Title: Notes on Lagrangian Mechanics
Date: June 24, 2016

These are notes based on Mechanics by Landau and Lifshitz. Going over the main points in each chapter and derivations which needed more detail

# Principle of Least Action

* Generalized Coordinates : Any $s$ quantities $q_1, q_2, ..., q_3$ which define the position of a system with $s$ degrees of freedom.
* Generalized Velocities : The respective time derivatives $\dot{q}_1, \dot{q}_2, ..., \dot{q}_3$ of the generalized coordinates

If at an instant all generalized coordinates $q$ and generalized velocities $\dot{q}$ are given, the accelerations $\ddot{q}$ at that instant are uniquely defined.

Mechanical motion is characterized by a function $L(q,\dot{q},t)$ and a condition where at instants $t_1, t_2$ in time the positions $q_1, q_2$ change such that the integral
$$
S = \int^{t_2}_{t_1} L(q,\dot{q},t) dt
$$
takes an extremum value. $L(q,\dot{q},t)$ is the _Lagrangian_, and $S$ the _Action_.

To determine under what conditions S is minimized, start with $q$ such that $S$ over times $t_1$, $t_2$ is at a minimum. Then any change in $q$, $q(t) \rightarrow q(t) + \delta q(t)$ increases $S$. Positions at $q(t_1)$, $q(t_2)$ are already known so $\delta q(t_1) = \delta q(t_2) = 0$.

Then the change in $S$ 

$$
\delta S = \int^{t_2}_{t_1} L(q + \delta q, \dot{q} + \delta \dot{q}, t) ~ dt - 
           \int^{t_2}_{t_1} L(q, \dot{q}, t) ~ dt
$$

Expanding $L(q + \delta q, \dot{q} + \delta \dot{q}, t)$ using the first order approximation $f(x_0 + \delta x) \approx f(x_0) + \delta x \frac{df}{dx} \Big \rvert_{x_0}$

$$
L(q + \delta q, \dot{q} + \delta \dot{q}, t) = L(q, \dot{q}, t) + \partial q \frac{\partial}{\partial q} L(q, \dot{q}, t) + \partial \dot{q} \frac{\partial}{\partial \dot{q}} L(q, \dot{q}, t) + \partial q ~ \partial \dot{q} \frac{\partial}{\partial q} \frac{\partial}{\partial \dot{q}} L(q, \dot{q}, t)
$$

Ignoring the second order term on the end, when $S$ is minimized and $\delta S = 0$ we have

$$
\int^{t_2}_{t_1} (\delta L - L) ~ dt = \int^{t_2}_{t_1} \left( \partial q ~ \frac{\partial L}{\partial q} + \partial \dot{q} ~ \frac{\partial L}{\partial \dot{q}} \right) dt = 0
$$

$$
\delta \dot{q} = \frac{d}{dt} \delta q
$$

$$
\int^{t_2}_{t_1} \left( \partial q ~ \frac{\partial L}{\partial q} + \frac{\partial L}{\partial \dot{q}} \frac{d}{dt} \delta q \right) dt = 0
$$

Now solving the second term inside the integral using integration by parts

$$
\int^{t_2}_{t_1} \frac{\partial L}{\partial \dot{q}} \frac{d}{dt} \delta q ~ dt = 
\left( \frac{\partial L}{\partial \dot{q}} \delta q \right) \Bigg \rvert^{t_2}_{t_1} - \int^{t_2}_{t_1} \delta q \frac{d}{dt} \frac{\partial L}{\partial \dot{q}} ~ dt
$$

Since $\delta q(t_1) = \delta q(t_2) = 0$ the first term vanishes. Substituting back, we have

$$
\delta S = \int^{t_2}_{t_1} \left( \frac{\partial L}{\partial q} - \frac{d}{dt} \frac{\partial L}{\partial \dot{q}} \right) \delta q ~ dt
$$

Since $\delta S = 0$ for all $\delta q$ we choose, the integrand itself must be zero

$$
\frac{d}{dt} \frac{\partial L}{\partial \dot{q}_i} - \frac{\partial L}{\partial q_i} = 0 \qquad i = 1, 2, ..., s
$$

Which is referred to as the Lagrange's Equations of Motion, written above for $s$ coordinates.

Lagrange's Equations describe the relationship between accelerations, velocities, and positions of a mechanical system. They yield $s$ 2nd order differential equations which require $2s$ boundary conditions to solve for the equations of motion in time $q_i (t)$

### Sidenote

The Lagrangian is not defined uniquely, the time derivative of any function dependent on position and time can be added.

$$
L'(q, \dot{q}, t) = L(q, \dot{q}, t) + \frac{d}{dt} f(q, t)
$$

$$
S' = \int^{t_2}_{t_1} L(q, \dot{q}, t) ~ dt + \int^{t_2}_{t_1} \frac{df}{dt} dt = S + f(q(t_2), t_2) - f(q(t_1), t_1)
$$

$$
\delta S' = \delta S + \delta \left( f(q(t_2), t_2) - f(q(t_1), t_1) \right)
$$

$$
\delta f(q(t_2), t_2) = f(q(t_2), t_2) - f(q(t_2) + \delta q(t_2), t_2) = f(q(t_2), t_2) - f(q(t_2), t_2) - \delta q(t_2) \frac{\partial f}{\partial q} \Big \rvert_{t_2}
$$

Since $\delta q(t_2) = 0$ by definition, $\delta f(q(t_2), t_2)$ and subsequently $\delta f(q(t_1), t_1)$ all vanish and $\delta S' = 0$

# Inertial Reference Frame

A frame of reference can always be chosen such that space is homogeneous and isotropic and time is also homogeneous. In this frame a free body which is at rest at an instant remains at rest. Such a frame is an _inertial frame of reference_.

The Lagrangian of a free particle in in an inertial frame of reference must then not explicitly contain the position vector $\vec{r}$ or or the time $t$ due to the homogeneity of space and time in an inertial frame. Thus the lagrangian of a free particle can only be a function of velocity $\vec{v}$. Additionally the isotropic property of space further restricts the Lagrangian to be a function of the magnitude of velocity only, $L = L(\vec{v} \cdot \vec{v})$.

Then $\partial L / \partial ~ \vec{r} = 0$ and Lagrange's equation for a free particle becomes

$$
\frac{d}{dt} \left( \frac{\partial L}{\partial ~ \vec{v}} \right) = 0
$$

# The Law of Inertia

We apply Lagrange's equation onto $L(\vec{v} \cdot \vec{v})$

$$
\frac{\partial L}{\partial ~ \vec{v}} = 2 ~ \vec{v} ~ L'(\vec{v} \cdot \vec{v})
$$

$$
\frac{d}{dt} \left( \frac{\partial L}{\partial ~ \vec{v}} \right) = 
2 ~ \vec{a} ~ L'(\vec{v} \cdot \vec{v}) + 4 ~ \vec{v} (\vec{a} \cdot \vec{v}) ~ L''(\vec{v} \cdot \vec{v}) = 0
$$

Taking the dot product of both sides with $\vec{v}$

$$
0 = 2 (\vec{a} \cdot \vec{v}) ( L'(\vec{v} \cdot \vec{v}) + 2 (\vec{v} \cdot \vec{v}) L''(\vec{v} \cdot \vec{v})
$$

In one solution $\vec{a} = 0$ and thus $\vec{v}$ is constant. The other solution arises from a differential equation

$$
L'(\vec{v} \cdot \vec{v}) + 2 (\vec{v} \cdot \vec{v}) L''(\vec{v} \cdot \vec{v}) = 0
$$

$$
L(\vec{v} \cdot \vec{v}) = \alpha \sqrt{\vec{v} \cdot \vec{v}} + \beta
$$

While this is differentiable with respect to $|v| = \sqrt{\vec{v} \cdot \vec{v}}$, it is not differentiable with respect to $\vec{v}$ for $\vec{v} = \vec{0}$ and $\frac{\partial L}{\partial ~ \vec{v}} = 0$ is no longer valid. Thus this second solution is inconsistent and discarded.

Thus
$$
\vec{v} = \text{constant}
$$

In any inertial frame, free motion takes place with a velocity constant in magnitude and direction. This is the _law of inertia_.

# Absolute Reference Frames and Galilean Relativity

Given another frame moving uniformly in a straight line relative to a given inertial frame free motion continues to take place with a constant velocity. This gives rise to an infinite number of reference frames in which the laws of mechanics are the same, constituting _Galileo's Relativity Principle_. The equivalence of these frames shows that there is no single absolute frame of reference.

Given two coordinates $\vec{r}$ and $\vec{r}'$ in two frames $K$ and $K'$ which the latter moves relative to the former with velocity $\vec{V}$, the coordinates are related by the _Galilean Transformation_

$$
\vec{r} = \vec{r}' + \vec{V} t
$$

# Free Particle Lagrangian

Comparing two inertial frames related by an infinitesimal velocity $\vec{\epsilon}$, the form of the lagrangians in each frame should remain the same that is depending only on the square of velocity. Further they should differ from each other only by the total time derivative of a function of coordinates and time.

Given the relation between the inertial frames, the velocities are related through $\vec{v}' = \vec{v} + \vec{\epsilon}$. The lagrangians are related then by

$$
L' = L(\vec{v}' \cdot \vec{v}') = L( (\vec{v} + \vec{\epsilon}) \cdot (\vec{v} + \vec{\epsilon}) ) =
L(\vec{v} \cdot \vec{v} + 2 \vec{v} \cdot \vec{\epsilon} + \vec{\epsilon} \cdot \vec{\epsilon} )
$$

Expanding to first order in terms of $v^2 = \vec{v} \cdot \vec{v}$

$$
L(v'^2) = L(v^2) + \frac{\partial L}{\partial v^2} 2 \vec{v} \cdot \vec{\epsilon}
$$

Since the second term already depends on $\vec{v}$ linearly, to remain so (and thus a total time derivative of position), $\partial L / \partial v^2$ must be independent of velocity. Thus the lagrangian is a linear function of $v^2$ up to a constant factor. Written as

$$
L = \tfrac{1}{2} m v^2
$$

By repeated transformations of infinitesimal relative velocities, the Lagrangian is also invariant for a finite relative velocity $V$ between frames.

$$
L' = \tfrac{1}{2} m v'^2 = \tfrac{1}{2} m (\vec{v} + \vec{V})^2 = \tfrac{1}{2} m v^2 + m \vec{v} \cdot \vec{V} + \tfrac{1}{2} m V^2 = L + d (m \vec{r} \cdot \vec{V} + \tfrac{1}{2} m V^2 t) / dt
$$

Where the second term is a total time derivative of position and time and does not affect the action $S$.

### Sidenote

An additional constant could be added, but it does not matter in terms of Lagrange's equations. Extremums don't change with constant shifts.

# Multiple Particle Lagrangian

For a system of particle which only interact with each other (closed system), the interaction can be described as a function of the coordinates $-U(r_1, r_2, ...)$ known as the _potential energy_.

$$
L = \sum \tfrac{1}{2} m_a v_a^2 - U(r_1, r_2, ...)
$$

This lagrangian is isotropic in time as well, reversing time does not affect the lagrangian and therefore the equations of motion. Plugging this into the Euler-Lagrange equations we arrive at

$$
\frac{d}{dt} \left( \frac{\partial}{\partial \dot{q}} \right) - \frac{\partial L}{\partial q} = 0
$$

$$
\frac{\partial L}{\partial v_a} = m_a v_a \qquad \frac{\partial L}{\partial r} = - \frac{\partial U}{\partial r_a}
$$

$$
\frac{d}{dt} m_a v_a = \frac{\partial U}{\partial r_a}
$$

$$
\text{Force} = m_a \frac{d v_a}{dt} = - \frac{\partial U}{\partial r_a}
$$

Where Force is expressed as in the classical Newton's Equation. The force, and thereby acceleration, only depend on the position of the system. These equations are identical up to a constant. The usual method is to define $U$ such that as $r \rightarrow \infty$, $U \rightarrow \infty$.

This lagrangian can be rewritten terms of generalized coordinates $q, \dot{q}$ by expressing the cartesian coordintaes $r_a$, $v_a$ in terms of the generalized coordinates.

$$
r_a = f(q_1, q_2, ..., q_s) \qquad v_a = \sum_k \frac{\partial f_a}{\partial q_k} \dot{q}_k
$$

$$
L = \tfrac{1}{2} \sum_k \frac{\partial f_a}{\partial q_k} \dot{q}_k \sum_i \frac{\partial f_a}{\partial q_i} \dot{q}_i - U(q) = \tfrac{1}{2} \sum_{i,k} a_{i,k} (q) \dot{q}_i \dot{q}_k - U(q)
$$

For two interacting Lagrangian systems $L_a$, $L_b$ the combined interaction is deonted as

$$
L = T_a (q_a, \dot{q}_a) + T_b (q_b, \dot{q}_b) - U(q_a, q_b)
$$

Where $T_{a}$, $T_{b}$ are the kinetic energy terms. To solve for $L_a$, we can treat $q_b$ as independent variables which depend on time, $q_b (t)$.

$$
L = T_a (q_a, \dot{q}_a) + T_b (q_b (t), \dot{q}_b (t)) - U(q_a, q_b (t))
$$

And then changing perspective and considering $t$ instead of $q_b (t)$, and $ T_b (q_b (t), \dot{q}_b (t))$ can be ignored as a time derivative of a function that depends only on time, the lagrangian is now considered as

$$
L = T_a (q_a, \dot{q}_a) - U(q_a, t)
$$

A free particle interacting with an external field is then given by

$$
L = \tfrac{1}{2} m v^2 - U(r, t)
$$

And the equations of motion yield

$$
m \dot{v} = - \frac{\partial U}{\partial r}
$$

If the force $F$ is independent of $r$ in the field, and thus the field is uniform,

$$
U(r, t) = -F \cdot r
$$