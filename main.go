package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"path"
)

type MyFs struct {
	http.Dir
}

func (m MyFs) Open(name string) (http.File, error) {
	fmt.Printf("Requested: %+v\n", name)
	file, err := m.Dir.Open(name)
	if err != nil {
		return nil, err
	}

	if name == "/" {
		return file, nil
	}

	info, err := file.Stat()
	if err != nil {
		return nil, err
	}

	if info.IsDir() {
		indexPage := path.Join(name, "index.html")
		indexFile, err := m.Dir.Open(indexPage)
		if err != nil {
			return nil, err
		}
		return indexFile, nil
	}
	return file, nil
}

var addr = flag.String("addr", ":8080", "server address")

func main() {
	flag.Parse()

	http.Handle("/", http.FileServer(MyFs{http.Dir("./public")}))

	log.Printf("Starting server on %s\n", *addr)
	err := http.ListenAndServe(*addr, nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
