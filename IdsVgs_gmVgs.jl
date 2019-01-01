using Plots

function IdsVgs_test()


    lmax=601
    #vgs= range(-1.0, stop=5.0, length=lmax)
    vgslow=-1.0
    vgshigh=5.0
    vgs= [vgslow+(vgshigh-vgslow)/lmax*n for n in 1:lmax]
    #vgs= range(vgslow, stop=vgshigh, length=lmax)
    dvgs=[ 5e-5 for n in 1:lmax]
    y= [ 0.1*n for n in 1:lmax ]
    w= [ 0.1*n for n in 1:lmax ]
    u= [ 0.1*n for n in 1:lmax ]
    v= [ 0.1*n for n in 1:lmax ]
    #z=1.0
    Vth=-0.9
    Vtro=1.60
    I0=0.26
    Imax=5.5
    k=1.13
    Ng=3.4
    #Vth=range(Vth0, step=0.0, length=201)
    #Vth=-1.0
    function f(z, dz)
        if z >= Vth
            r=(z - Vth) ^Ng
        else
            r=0.0
        end
        return r
    end
    function g(z, dz)
        r=Imax/(1+exp(-(z-Vtro)/k))+I0
        return r
    end

    function Ids0(z, dz)
            r=1/( 1/f(z, dz) + 1/g(z, dz))
            return r
    end

    function gm0(z, dz)
        r=(Ids0(z+dz, dz)-Ids0(z-dz, dz))/(2*dz)
        return r
    end

    function gm02(z, dz)
        r=(gm0(z+dz, dz)-gm0(z-dz, dz))/(2*dz)
        return r
    end

    function gm03(z, dz)
        r=(gm02(z+dz, dz)-gm02(z-dz, dz))/(2*dz)
        return r
    end

    for i=1:lmax
        y[i]=Ids0(vgs[i], dvgs[i])
        w[i]=gm0(vgs[i], dvgs[i])
        u[i]=gm02(vgs[i], dvgs[i])
        v[i]=gm03(vgs[i], dvgs[i])
    end
    ymax=findmax(y)[1]
    wmax=findmax(w)[1]
    umax=findmax(u)[1]
    vmax=findmax(v)[1]

    ymin=findmin(y)[1]
    wmin=findmin(w)[1]
    umin=findmin(u)[1]
    vmin=findmin(v)[1]

    dy=ymax-ymin
    dw=wmax-wmin
    du=umax-umin
    dv=vmax-vmin

    plot(vgs, [y./dy, w./dw, u./du, v./dv])

    #println(dy,"  ", dw, "  ", du, "  ", dv)
    #println("Finish")
end

IdsVgs_test()
