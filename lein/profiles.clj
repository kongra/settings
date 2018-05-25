{:user {:plugins [[lein-pprint        "1.2.0"]
                  [lein-ancient      "0.6.15"]
                  [lein-bikeshed      "0.5.1"]
                  [jonase/eastwood    "0.2.6"]
                  [lein-kibit         "0.1.6"
                   :exclusions
                   [org.clojure/tools.namespace
                    org.clojure/tools.cli]]]

        :signing      {:gpg-key   "CF1B5B02"}
        :dependencies [[criterium    "0.4.4"]]

        ;; :jvm-opts     ["-server"
        ;;                "-d64"
        ;;                "-Dclojure.compiler.direct-linking=true"

        ;;                "-Xshare:off"
        ;;                "-XX:+AggressiveOpts"
        ;;                "-XX:+DoEscapeAnalysis"
        ;;                "-XX:+UseCompressedOops"
        ;;                ;; "-XX:+UseNUMA" ;; to check: numactl --hardware

        ;;                "-Xms1G"
        ;;                "-Xmx1G"

        ;;                "-XX:+UseParallelGC"
        ;;                "-XX:+UseParallelOldGC"
        ;;                "-XX:NewSize=400m"
        ;;                "-XX:MaxNewSize=400m"
        ;;                "-XX:-UseAdaptiveSizePolicy"
        ;;                "-XX:SurvivorRatio=6"

        ;;                "-XX:+PrintGCDetails"
        ;;                "-XX:+PrintGCTimeStamps"]

        }
 }
