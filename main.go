package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
)

func writeLogFile(txt string, customUrl string) {
	filePath := "log/callback" + customUrl + ".log"
	file, err := os.OpenFile(filePath, os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0644)

	if err != nil {
		log.Fatal(err)
	}

	defer file.Close()

	log.SetOutput(file)
	log.Print(txt)
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "I am index")
}

func callbackHandler(w http.ResponseWriter, r *http.Request) {
	urlPath := r.URL.Path
	urlPath = strings.ReplaceAll(urlPath, "/callback", "")
	urlPath = strings.ReplaceAll(urlPath, "/", "_")
	urlPath = strings.TrimRight(urlPath, "_")

	if r.Method == http.MethodGet {
		queryParamsStr := r.URL.Query().Encode()

		writeLogFile(queryParamsStr, urlPath)
	} else if r.Method == http.MethodPost {
		// Parse dynamic json to map
		var result map[string]interface{} // Declared an empty interface

		decoder := json.NewDecoder(r.Body)
		err := decoder.Decode(&result)

		if err != nil {
			panic(err)
		}

		// Parse map to json
		jsonString, err1 := json.Marshal(result)

		if err1 != nil {
			fmt.Println(err1)
			return
		}

		writeLogFile(string(jsonString), urlPath)
	} else {
		fmt.Fprintf(w, "Could not handle "+r.Method+" request method")
	}

	// write your logic here to make sure the callback data is valid
	// if valid, then return OK
	w.Write([]byte("OK"))
}

func main() {
	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/callback/", callbackHandler)
	http.ListenAndServe(":8000", nil)
}
