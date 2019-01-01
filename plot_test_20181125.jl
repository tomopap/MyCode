using Plots

xlow = -0.0
xstep = 0.1
imax = 101
#x = range(xlow, step=xstep, length=imax)
x = [xlow + (xhigh-xlow)/imax*(n-1) for n in 1:imax]

ylow=-1.0
ystep=0.2
jmax=8
yhigh = ylow + ystep*(jmax)
#y = range(ylow, step=ystep, length=jmax)
y = [ylow + (yhigh-ylow)/jmax*(n-1) for n in 1:jmax]
#x = range(xlow, stop = xhigh, length = imax)

Imax=0.5
Vsat=1.0
Vth=-1.0
Ngr=2.5
Gamma = 1e-3
Gamma2 = 1e-3
Kappa = 1e-9

p=[Imax, Vsat, Vth, Ngr, Gamma, Kappa, Gamma2]

function Ids(x::Array{Float64, 1}, y::Array{Float64, 1}, p::Array{Float64, 1})
    #p[1]./(p[2] .+ exp.( .-(x.-y) .*p[3]))
    vgst = y.-p[3].+p[5].*x .+p[7].*x.^2
        if vgst < zero(x)
            Ix = zero(x)
        else
            Ix = p[1].*tanh.(p[2].*x).*vgst.^p[4] ./ (p[1] .+vgst.^p[4] )
        end
        return Ix .+ p[6].*x
end

function Idsx(x::Float64, y::Float64, p::Array{Float64, 1})
    vgst = y - p[3] - p[5]*x
    if vgst < 0.0
        Ix = 0.0
    else
        Ix = p[1]*tanh(p[2]*x)*((y-p[3])^p[4] / (p[1] +(y-p[3] - p[5]*x)^p[4] ))
    end
    return Ix + p[6]*x
end



plot(
    plot(x, [Ids(x, y[j], p) for j in 1:length(y)]),

    plot(rand(10)),
    plot(rand(20)),
    plot(rand(30)),
    legend=:none
#    layout=(4,4),size=(800,800),legend=:none
)
