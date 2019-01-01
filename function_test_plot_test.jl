using Plots

Imax=0.5
Vsat=0.5
Vth=-1.0
Ngr=2.0
Gamma = 1e-3
Gamma2 = 2.0e-4
Kappa = 1e-5

p=[Imax, Vsat, Vth, Ngr, Gamma, Kappa, Gamma2]

function Idsx(x::Float64, y::Float64, p::Array{Float64, 1})
    vgst = y-p[3] + p[5]*x + p[7]*x^2
    if vgst < 0.0
        Ix = 0.0
    else
        Ix = p[1]*tanh(p[2]*x)*((y-p[3] + p[5]*x + p[7]*x^2 )^p[4] / (p[1] +(y-p[3] + p[5]*x + p[7]*x^2 )^p[4] ))
    end
    return Ix + p[6]*x
end

#println(Idsx(1.0, 1.0, p))

imax=101
jmax=11
Ix=Array{Float64}(undef, imax, jmax)
xlow = -0.0
xhigh = 20.0
xstep = (xhigh-xlow)/imax

ylow = -1.0

for j=1:jmax
    y = ylow + 0.1*(j-1)
    for i=1:imax
        x = xlow + xstep*(i-1)
        Ix[i,j] = Idsx(x, y, p)
    end
end

xx = [xlow + xstep*(i-1) for i in 1:imax]
yy = [0.0 + 0.1*(j-1) for j in 1:jmax]

plot(xx, [Ix[:,j] for j in 1:jmax], legend=:none)
