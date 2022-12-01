using PlotlyJS
using StatsBase
using DSP
using Distributions
using FFTW

L = 128
N = 2
d = Normal()

#X1 = rand(d, L)
#X2 = rand(d, L)
#X3 = rand(d, L)
#X4 = rand(d, L)
#
#P1 = fft(X1)
#P2 = fft(X2)
#P3 = fft(X3)
#P4 = fft(X4)
#
#S1 = (abs.(P1).^2)/L
#S2 = (abs.(P2).^2)/L
#S3 = (abs.(P3).^2)/L
#S4 = (abs.(P4).^2)/L

t = 0:L
freqs = fftfreq(length(t), 1)
freqs = fftshift(freqs)

S = ones(Float32,L)

#t1 = scatter(mode="lines", x=t, y=abs.(S1), name="S1")
#t2 = scatter(mode="lines", x=t, y=abs.(S2), name="S2")
#t3 = scatter(mode="lines", x=t, y=abs.(S3), name="S3")
#t4 = scatter(mode="lines", x=t, y=abs.(S4), name="S4")
t5 = scatter(mode="lines", x=t, y=S, name="Analitico")
#
#display( plot([t1, t2, t3, t4, t5]) )

S = zeros(Float32,L)
V = S
for i in 1:N
	X = rand(d,L)
	P = fft(X)
	Per = (abs.(P).^2)/L
	global S += Per
	global V += (Per.-1).^2
end
S /= N
V /= (N-1)

t1 = scatter(mode="lines", x=t, y=abs.(S), name="Sx")
t2 = scatter(mode="lines", x=t, y=abs.(V), name="Var")
display( plot([t1, t2, t5]) )

readline()
