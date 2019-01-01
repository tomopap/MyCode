using Optim
using Distributions
using Plots


function opttest()

    imax=610
    jmax=5

    x = [-1.0+0.01*n for n in 1:imax]
    y = [-1.0+0.1*n for n in 1:jmax]
    p = [1, 2, 3, 4, 5, 6]

    function measdata(x, y)
        tanh(y/7.0-x)*(x-1.0+0.01*y)^(2.0)
    end

    function model(x, y, p)
        p[1]*tanh(y./p[2] .-p[5].*x +p[6] ).*abs(x-p[3]+p[4].*y)^(2.0)
    end

    function res(x, y, p)
        (model(x, y, p) .- measdata(x, y)).^2
    end

    function ressumsq(p)
        sum(sum( res(x[i], y[j], p) for i=1:imax) for j=1:jmax)
    end

    #m = Normal(0, 1.0)
    #p0 = 0.3*rand(m, 6)



    #for j=1:jmax
        #plot(x, [measdata(x, y[1]), model(x, y[1], p0)])
    #end

    #h(x, y) = tanh(y/7.0-x)*(x-1.0+0.01*y)^(2.0)
    #f(p, x, y) = (p[3] .+ 1.0 .*y - p[1].*x)^2 + ((p[2].*x - p[1]^2 .*y)^2)*(2.0/p[4]) .- h(x, y)
    #f(p, x, y) = (p[1]*tanh(y./p[2] .-p[5].*x +p[6] ).*abs(x-p[3]+p[4].*y)^(2.0) .- h(x, y)).^2
    #g(p)=sum(sum(f(p,x[j], y[k]) for j=1:imax) for k=1:kmax)

    p0low = [-20.0, -10.0, -10.0, -10.0, -1.0, -1.0]
    p0high=[20.0, 20.0, 10.0, 10.0, 1.0, 1.0]

    NMAX=100
    iterx = [ n for n in 1:NMAX]
    fminx = [ 0.0*n for n in 1:NMAX]
    ict =0

    for i in 1:NMAX
        m = Normal(0, 1.0)
        r = 0.5*rand(m, 6)
        println("$i times")
        p0 = [r[1], r[2], r[3], r[4], r[5], r[6]] #初期値を0,0とした。
        #println(p0)
        evalfunc = optimize(ressumsq, p0low, p0high, p0, SimulatedAnnealing(), Optim.Options(iterations=100))
        xsol1 = Optim.minimizer(evalfunc) #関数fを最小化するxの値
        println("xsol_by_SA = $xsol1")
        fmin1 = Optim.minimum(evalfunc) #関数fの最小値
        println("fmin_by_SA = $fmin1")

        evalfunc = optimize(ressumsq, p0low, p0high, xsol1, NelderMead(), Optim.Options(iterations=500))
        xsol2 = Optim.minimizer(evalfunc) #関数fを最小化するxの値
        println("xsol_by_SA = $xsol2")
        fmin2 = Optim.minimum(evalfunc) #関数fの最小値
        println("fmin_by_SA = $fmin2")

        evalfunc = optimize(ressumsq, p0low, p0high, xsol2, NelderMead(), Optim.Options(iterations=2500))
        xsol = Optim.minimizer(evalfunc) #関数fを最小化するxの値
        println("xsol_SA_NM = $xsol")
        fmin = Optim.minimum(evalfunc) #関数fの最小値
        #fminx[i]=convert(Float64,  fmin)
        fminx[i]=fmin
        println("fmin_SA_NM = $fmin")

        if fmin < 1.0e-5
            ict += 1
            println("ict = $ict")
        else
            println("Big")
        end

        println("")
    end
    println("num of fmin<1e-6 : $ict")
    plot(iterx, fminx; yaxis=:log)
end

opttest()
