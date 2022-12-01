using PlotlyJS
using StatsBase
using DSP
using Distributions
using FFTW

L = 128
N = 500
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
for i in 1:N
	X = rand(d,L)
	P = fft(X)
	global S += (abs.(P).^2)/L
end
S /= N

t1 = scatter(mode="lines", x=t, y=abs.(S), name="S")
display( plot([t1, t5]) )

readline()

#N = rand(-n:0.1:n,1,L*8)
#N = transpose(N)
R = range(0, L, length=L*8)
N = @. sin(R)* n + 0.01 * randn() 
M = vec(M1 .+ M2 .+ N)

display(plot(scatter(mode="lines", x=1:length(M), y=M[:], name="M", line_shape="hvh",line=attr(color="green"))))
display(plot(scatter(mode="lines", x=1:length(N), y=N[:], name="N", line_shape="hvh",line=attr(color="green"))))

l=vec(-L:L*8-1)
S1 = vec(hcat(S1,zeros(Int64,1,L*7)))
R1 = crosscor(S1,M,l;demean=false)*(L*8+L*8-1)

S2 = vec(hcat(S2,zeros(Int64,1,L*7)))
R2 = crosscor(S2,M,l;demean=false)*(L*8+L*8-1)

responsetype = Bandstop(0.015, 0.03; fs=1)
designmethod = Butterworth(6)
R1 = filt(digitalfilter(responsetype, designmethod), R1)
R2 = filt(digitalfilter(responsetype, designmethod), R2)

p7 = plot(scatter(mode="lines", x=1:length(R1), y=R1[:], name="R1", line_shape="hvh",line=attr(color="royalblue")))
p8 = plot(scatter(mode="lines", x=1:length(R2), y=R2[:], name="R2", line_shape="hvh",line=attr(color="firebrick")))

r =[p7 p8]
relayout!(r)
display(r)

readline()
