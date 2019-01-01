function test()
    ict = 0
    for i in 1:10
        if i<5
            ict += 1
        end
    end
    println("ict = $ict")
end
test()
