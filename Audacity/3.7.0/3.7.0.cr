class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr        \
                                    -DCMAKE_BUILD_TYPE=Release          \
                                    -DAUDACITY_BUILD_LEVEL=2            \
                                    -Daudacity_conan_enabled=off        \
                                    -Daudacity_has_updates_check=off    \
                                    -Daudacity_has_audiocom_upload=off  \
                                    -Daudacity_has_sentry_reporting=off \
                                    -Daudacity_has_crashreports=off     \
                                    -Daudacity_has_tests=off            \
                                    ..",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

end
