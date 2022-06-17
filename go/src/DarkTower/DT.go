package main

import "fmt"

func main() {
    p:=DTPlayer{}
    p.init()
    fmt.Println(p)
    for ; p.warriors>1 ; {
        p.startTurn()
        p.endTurn()
        fmt.Println(p)
    }
}
