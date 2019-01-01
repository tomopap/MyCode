using Plots

data1d=rand(10)
data1d2=rand(10)
data1d3=rand(10)
data2d=[rand()/5 + exp(-(x^2+y^2)/100) for x in -10:10, y in -10:10]
data1dp=0:2pi/10:2pi;

function example(no3d=false,forpgf=false)
    plot(
        plot(data1d),
        plot(data1d,xscale=:log10,yscale=:log10),
        plot(data1d,seriestype=:steppre),
        plot(data1d,seriestype=:step),
        plot(data1d,seriestype=:scatter),
        plot(data1d,seriestype=:bar),
        forpgf ? plot() : plot(data1d,seriestype=:pie),
        plot(data2d,seriestype=:contour,legend=:none),
        plot(data2d,seriestype=:contour,fill=true,legend=:none),
        no3d ? plot() : plot(data2d,seriestype=:surface,legend=:none),
        forpgf ? plot() : plot(data2d,seriestype=:wireframe),
        forpgf ? plot() : plot(data2d,seriestype=:heatmap,legend=:none),
        plot(data1dp,data1d,proj=:polar),
        plot(data1d,data1d2,data1d2,seriestype=:scatter3d),
        plot(data1d,data1d2,data1d2),
        plot([0,1,0,-1],[-1,0,1,0],seriestype=:shape),
        layout=(4,4),size=(800,800),legend=:none
    )
end
