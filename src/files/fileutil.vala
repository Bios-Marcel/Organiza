using GLib.Math;

namespace FileUtil {
    const int64 KILO = 1024;
    const int64 MEGA = 1048576;
    const int64 GIGA = 1073741824;
    const int64 TERA = 1099511627776;
    const int64 PETA = 1125899906842624;
    const int64 EXA = 1152921504606846976;

    /**
     * Converts a given file size into a simple, binary representation, that is
     * meant to be comprehensible to human nerds.
     *
     * While the rest of the world has standardized on the meanings of
     *
     * * kilo (1000)
     * * mega (1000^2)
     * * giga (1000^3)
     * * tera (1000^4)
     * * peta (1000^5)
     * * exa (1000^6)
     *
     * computer scientist of course, had to be special snowflakes and repurpose
     * those words as
     *
     * * kilo (1024)
     * * mega (1024^2)
     * * giga (1024^3)
     * * tera (1024^4)
     * * peta (1024^5)
     * * exa (1024^6)
     *
     * because 1024 is a power of 2 and for hackers it makes a lot of sense to
     * talk about file sizes in base 2.
     *
     * This has lead to the confusing situation where hard drive manufactureres
     * state disk sizes with one standard, but software reports size with another.
     *
     * There has been an effort to standardize away from the established terms by
     * inventing new ones for base 2 sizes (kibi, mibi, gibi,...) but those have
     * been largely ignored.
     *
     * Since we do not want to upset the fragile minds of hackers, the intended
     * audience for this tool, we stick to the classical nomenclature (kilo, mega,...)
     * but report sizes in base 2.
     *
     * In GLib file sizes cannot exceed int64.MAX (18446744073709551615 == 2^64 - 1) bytes.
     * For this reason, we cannot exceed sizes larger than exa (1152921504606846976 == 2^60).
     * But who would ever need that much storage? Seems crazy, right? Right *sarcasm-face*?
     *
     * Additionally, in order to avoid localization issues (comma vs. period), this
     * function returns integer precision sizes.
     *
     * Sources:
     *
     * * [[https://en.wikipedia.org/wiki/Binary_prefix|wikipedia.org/Binary_prefix]]
     * * [[https://en.wikipedia.org/wiki/International_System_of_Units|wikipedia.org/International_System_of_Units]]
     * * [[https://en.wikipedia.org/wiki/International_Electrotechnical_Commission|wikipedia.org/International_Electrotechnical_Commission]]
     * * [[https://networkengineering.stackexchange.com/questions/3628/iec-or-si-units-binary-prefixes-used-for-network-measurement|networkengineering.stackexchange.com/iec-or-si-units-binary-prefixes-used-for-network-measurement]]
     *
     * @param file_size the file size in bytes, as reportes by GLib.
     *
     * @return a readable, consise formatting of the given file size. Will be empty
     * if ``file_size`` is negative.
     */
    << << << < HEAD
    public string as_nerd_readable_file_size(int64 file_size) {
        if ( file_size < 0 ) {
            // what does a negative file size even mean?
            || || || | merged common ancestors
            public string as_nerd_readable_file_size(int64 file_size) {
                if ( file_size < 0 ) {
                    // what does a negative file size even mean?
                    == == == =
                        public string as_nerd_readable_file_size(int64 file_size) {
                        if ( file_size < 0 ) {
                            // what does a negative file size even mean?
                            >> >> >> > 2cc7ee33ac6435321a6781bc265761c44eef0feb
                            // obviously, FileInfo.get_size mentions none of it...
                            return "";
                        }

                        << << << < HEAD
                        double normalized_size = (double) file_size;
                        var suffix = "B";
                        || || || | merged common ancestors
                        double normalized_size = (double) file_size;
                        var suffix = "B";
                        == == == =
                            double normalized_size = (double) file_size;
                        var suffix = "B";
                        >> >> >> > 2cc7ee33ac6435321a6781bc265761c44eef0feb

                        // in case of performance concerns, the order of these if-blocks
                        // could be swapped. however, without benchmarks that would be pointless.
                        // even with benchmarks, one has to consider typical file sizes (1KB - 1 GB
                        // in 2018, would be my guess) as opposed to all possible file sizes.
                        //
                        // i have also experimented with fast bitwise integer operations.
                        // however, that proved to be very imprecise for any number not cleanly
                        // divisible by 2. i am sure, it would be possible enhance the accuracy
                        // of integer divisions, but
                        // a. the effort should only be undertaken in case of perf problems
                        // b. surely, some lib out there has solved this already.

                        if ( file_size >= KILO ) {
                            normalized_size = normalized_size / 1024;
                            suffix = "KB";
                        }
                        if ( file_size >= MEGA ) {
                            normalized_size = normalized_size / 1024;
                            suffix = "MB";
                        }
                        if ( file_size >= GIGA ) {
                            normalized_size = normalized_size / 1024;
                            suffix = "GB";
                        }
                        if ( file_size >= TERA ) {
                            normalized_size = normalized_size / 1024;
                            suffix = "TB";
                        }
                        if ( file_size >= PETA ) {
                            normalized_size = normalized_size / 1024;
                            suffix = "PB";
                        }
                        if ( file_size >= EXA ) {
                            normalized_size = normalized_size / 1024;
                            suffix = "EB";
                        }

                        return @ "$(round(normalized_size)) $suffix";
                    }

                    /**
                     * Returns the size of a given file or or folder. In case the given file is a folder, the size will be calcualted recursively.
                     */
                    public bool is_directory(File file) {
                        // FIXME: GLib already has FileUtils and FileTest for this purpose.
                        return file.query_file_type (FileQueryInfoFlags.NONE) == FileType.DIRECTORY;
                    }

                    /**
                     * Returns the size of a given file or `0` if given file is a folder.
                     */
                    public int64 get_file_size(File file) {
                        try {
                            FileInfo fileInfo = file.query_info ("standard::*", FileQueryInfoFlags.NONE);
                            if ( fileInfo.get_file_type () == FileType.DIRECTORY ) {
                                int64 size = 0;

                                var enumerator = file.enumerate_children ("standard::*", FileQueryInfoFlags.NOFOLLOW_SYMLINKS);

                                FileInfo childFileInfo;
                                while ((childFileInfo = enumerator.next_file ()) != null ) {
                                    size += get_file_size (file.resolve_relative_path (childFileInfo.get_name ()));
                                }

                                return size;
                            } else {
                                return fileInfo.get_size ();
                            }
                        } catch (Error error) {
                            warning (error.message);
                            return 0;
                        }
                    }

                }
