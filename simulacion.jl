using PlotlyJS
using StatsBase
using DSP

L = 100

S1 = rand(-1:2:1, 1, L)
S2 = rand(-1:2:1, 1, L)

d1 = [1,1,-1,-1,1,1,-1,-1]
d2 = [-1,1,-1,1,1,-1,1,-1]

M1 = reshape(transpose(d1*S1),:,1)
M2 = reshape(transpose(d2*S2),:,1)

p1 = plot(scatter(mode="lines", x=0:length(d1), y=d1, name="d1", line_shape="hvh",line=attr(color="royalblue")))
p2 = plot(scatter(mode="lines", x=0:length(d2), y=d2, name="d2", line_shape="hvh",line=attr(color="firebrick")))
p3 = plot(scatter(mode="lines", x=0:length(S1), y=S1[:], name="S1", line_shape="hvh",line=attr(color="royalblue")))
p4 = plot(scatter(mode="lines", x=0:length(S2), y=S2[:], name="S2", line_shape="hvh",line=attr(color="firebrick")))
p5 = plot(scatter(mode="lines", x=1:length(M1), y=M1[:], name="M1", line_shape="hvh",line=attr(color="royalblue")))
p6 = plot(scatter(mode="lines", x=1:length(M2), y=M2[:], name="M2", line_shape="hvh",line=attr(color="firebrick")))

p =[p1 p2; p3 p4; p5 p6]
relayout!(p)
display(p)

n = 5
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
