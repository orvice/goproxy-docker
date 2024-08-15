package main

import (
	"net/http"

	"github.com/goproxy/goproxy"
)

func main() {
	http.ListenAndServe("localhost:8080", &goproxy.Goproxy{
		ProxiedSumDBs: []string{"sum.golang.org"},
	})
}
