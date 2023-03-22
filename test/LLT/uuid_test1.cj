
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from uuid import uuid.*

main() {  
   
    let a: Int64 = -5218938979965909021
     let b: Int64 = 5218938979965909021
    let c:Int64 = 51671113647436103
    let d: Int64 = (c << 8)
    let e: Int64 = ((c << 8) | (227 & 0xff))

    println(a.format("0B"))
    // println(a | b)
    println(b.format("0b"))
    println(c.format("0b"))
    println(d.format("0b"))
    println(e.format("0b"))

}