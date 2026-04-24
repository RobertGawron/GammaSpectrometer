You must decide:

Do you want:

A) Analog noise ≤ quantization noise (very strict)
or
B) System ENOB ≥ X bits (realistic system requirement)

Engineering-wise, B is cleaner.

Real ADC Has Internal Noise
Look at AD9238 datasheet:

Typical SNR ≈ 70 dB (low input frequency).

Convert to ENOB:

E
N
O
B
=
S
N
R
−
1.76
6.02
ENOB=
6.02
SNR−1.76
​

E
N
O
B
=
70
−
1.76
6.02
≈
11.3
 bits
ENOB=
6.02
70−1.76
​
 ≈11.3 bits
So even ideal analog front-end will not give 12 ENOB.

Best case ≈ 11–11.3 bits.

✅ 3️⃣ Why I Said 10.5
Because:

ADC intrinsic ENOB ≈ 11 bits
Some margin needed
Practical bandwidth and frequency reduce ENOB further
Your anti-alias filter + driver may slightly degrade SNR
10.5 bits is conservative but realistic.

If you demand 11 bits system-level, that is stricter.

If you demand 12 bits system-level, it is physically impossible.

✅ 4️⃣ What Happens If You Demand 12 ENOB?
Required SNR:

S
N
R
=
6.02
×
12
+
1.76
=
74
d
B
SNR=6.02×12+1.76=74dB
But ADC intrinsic SNR ≈ 70 dB.

So system cannot meet 12 ENOB regardless of AFE quality.

That makes requirement invalid.

✅ 5️⃣ Correct Engineering Approach
First determine:

ADC intrinsic ENOB at your signal frequency
That is upper system bound
Then require:

E
N
O
B
s
y
s
t
e
m
≥
E
N
O
B
A
D
C
−
m
a
r
g
i
n
ENOB
system
​
 ≥ENOB
ADC
​
 −margin
That margin might be 0.2–0.5 bits.


 Step 1 — Compute Required SNR
S
N
R
=
6.02
⋅
E
N
O
B
+
1.76
SNR=6.02⋅ENOB+1.76
For 10.5 bits:

S
N
R
=
6.02
×
10.5
+
1.76
=
63.21
+
1.76
=
64.97
 dB
≈
65.0
 dB
SNR=6.02×10.5+1.76=63.21+1.76=64.97 dB≈65.0 dB
✅ Step 2 — Convert to Maximum RMS Noise
Full-scale differential = 2 Vpp

V
s
i
g
n
a
l
,
r
m
s
=
2
V
p
p
2
2
=
0.707
V
V
signal,rms
​
 =
2
2
​

2V
pp
​

​
 =0.707V
Maximum allowable total RMS noise:

V
n
o
i
s
e
,
m
a
x
=
0.707
10
(
65
/
20
)
V
noise,max
​
 =
10
(65/20)

0.707
​

10
(
65
/
20
)
=
1778
10
(65/20)
 =1778
V
n
o
i
s
e
,
m
a
x
=
0.707
1778
≈
0.000398
V
≈
398
µ
V
R
M
S
V
noise,max
​
 =
1778
0.707
​
 ≈0.000398V≈398µVRMS
✅ Result
For 10.5 ENOB target:

V
n
o
i
s
e
,
m
a
x
≈
398
µ
V
R
M
S
V
noise,max
​
 ≈398µVRMS
Round cleanly:

text

400 µV RMS
That is your correct analog differential noise ceiling.
