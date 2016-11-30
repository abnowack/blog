Title: December
Date: December 24, 2016

Not sure where the past few months went .. trying to get back into it.

Working on creating a Python library for reading neutron data files (cross sections, multiplicity, more?) directly to be able to calculate quantities and probabilities within scripts.

Thought of several options
* Query the NNDC website directly for each quantity.
* Download / Read ENDF files, either downloaded from NNDC or a local MCNP install
* Download / Read ACE formatted files, either downloaded from NNDC or a local MCNP install

Of the options reading ACE formatted files seemed to be the simplest, basically because ENDF data files may contain several errors.

In the MCNP format the latest data release from ENDF/B-VII.1 Release 0 is stored in ACE format at: $MCNP_DIR\MCNP_DATA\xdata\endf71x

From inspection, I think the data description is done through the file name and the ACE file contains a simple header and then plain tabulated cross-section data.

### ACE Filename Format

With ENDF/B-VII.1 a new ACE filename format was created called SZAX identifiers, in addition to a modified header format. This is detailed in LA-UR-12-25177

SSSZZZAAA.dddCC

SSS - Excited State
ZZZ - Atomic Number
AAA - Atomic Mass Number
ddd - Library Identifier
CC  - Class of Data

Given S (excited state), Z and A the SZA identifier can be structed as

SZA = S * 1000000 + Z * 1000 + A

The suffix (dddCC) described the data classes and is listed as

Class (CC) | Incident Particle | Description
---------- | ----------------- | -----------
nc         | Neutron           | Transport, continuous-energy
nd         | Neutron           | Transport, discrete-reaction
nm         | Neutron           | Transport, multigroup
pp         | Photon            | Photoatomic, continuous-energy
pu         | Photon            | Photonuclear, continuous-energy
ny         | Neutron           | Dosimetry
nt         | Neutron           | Thermal S(alpha, beta) discrete or continuous-energy

### ACE Header Format

```
FMTVERSION SZAX SOURCE
ATWGTR TEMP DATE N
N lines of comments
```

Variable      | Format         | Description
------------- | -------------- | -----------
FMTVERSION    | 10 ASCII CHAR  | Format Version Number (2.0.0)
SZAX          | 24 ASCII CHAR  | SZA + suffi(X)
SOURCE        | 24 ASCII CHAR  | Source of data (ENDF/B-VII.1)
ATWGTR        | 12 CHAR NUMBER | Atomic Weight Ratio of nuclide to neutron
TEMP          | 12 CHAR NUMBER | Temperature of processed data (in MeV)
DATE          | 8 ASCII CHAR   | Date when data table was created
N             | INTEGER        | Number of comment lines
Comment Lines | 70 ASCII CHAR  | N 70 Character long comment lines

```
ZZZAAA_1  ATWGTR_1  ZZZAAA_2  ATWGTR_2  ZZZAAA_3  ATWGTR_3  ZZZAAA_4  ATWGTR_4
ZZZAAA_5  ATWGTR_5  ZZZAAA_6  ATWGTR_6  ZZZAAA_7  ATWGTR_7  ZZZAAA_8  ATWGTR_8
ZZZAAA_9  ATWGTR_9  ZZZAAA_10 ATWGTR_10 ZZZAAA_11 ATWGTR_11 ZZZAAA_12 ATWGTR_12
ZZZAAA_13 ATWGTR_13 ZZZAAA_14 ATWGTR_14 ZZZAAA_15 ATWGTR_15 ZZZAAA_16 ATWGTR_16
```

16 pairs of ZZZAAA and atomic weight ratios needed in the past for photoatomic tables but now ignored. The ZZZAAA are still used for thermal tables to indicate what scattering data is appropriate.

This is then followed by the NXS array

```
NXS(1) NXS(2) ... NXS(8)
NXS(9) NXS(10) ... NXS(16)
```

The definitions for continuous-energy neutron data is given as follows

NTY     | Description
------- | -----------
NXS(1)  | Length of second block of data
NXS(2)  | ZA = 1000 * Z + A
NXS(3)  | NES = Number of Energies
NXS(4)  | NTR = Number of reactions excluding elastic
NXS(5)  | NR = Number of reactions having secondary neutrons excluding elastic
NXS(6)  | NTRP = Number of photon production reactions
NXS(7)  | 
NXS(8)  | NPCR = Number of delayed neutron precursor families
NXS(9)  | Excited State Number
NXS(10) | Atomic Number
NXS(11) | Atomic Mass Number
NXS(12) | 
NXS(13) | 
NXS(14) | 
NXS(15) | NT = Number of PIKMT reactions
NXS(16) | 0 = Normal Photon Production, -1 = Do not produce photons

This is then followed by the JXS array

```
JXS(1) JXS(2) ... JXS(8)
JXS(9) JXS(10) ... JXS(16)
JXS(17) JXS(18) ... JXS(24)
JXS(25) JXS(26) ... JXS(32)
```

The definitions for continuous-energy neutron data is given as follows

NTY     | Description
------- | -----------
JXS(1)  | ESZ = Location of Energy Table
JXS(2)  | NU = Location of fission nu data
JXS(3)  | MTR = Location of MT array
JXS(4)  | LQR = Location of Q-Value array
JXS(5)  | TYR = Location of Reaction Type array
JXS(6)  | LSIG = Location of table of cross-section locators
JXS(7)  | SIG = Location of cross sections
JXS(8)  | LAND = Location of table of angular distribution locators
JXS(9)  | AND = Location of angular distributions
JXS(10) | LDLW = Location of table of energy distribution locators
JXS(11) | DLW = Location of Energy distributions
JXS(12) | GPD = Location of photon production data
JXS(13) | MTRP = Location of Photon production MT array
JXS(14) | LSIGP = Location of table of photon production cross-section locators
JXS(15) | SIGP = Location of photon production cross sections
JXS(16) | LANDP = Location of table of photon production angular distribution locators
JXS(17) | ANDP = Location of photon production angular distributions
JXS(18) | LDLWP = Location of table of photon production energy distribution locators
JXS(19) | DLWP = Location of photon production energy distributions
JXS(20) | YP = Location of table of yield multipliers
JXS(21) | FIS = Location of Total Fission cross-section
JXS(22) | END = Location of last word of this table
JXS(23) | LUNR = Location of probabilitity tables
JXS(24) | DNU = Location of delayed nubar data
JXS(25) | BDD = Location of basic delayed data
JXS(26) | DNEDL = Location of table of energy distribution locators
JXS(27) | DNED = Location of energy distributions
JXS(28) | 
JXS(29) | 
JXS(30) | 
JXS(31) | 
JXS(32) | 