/** @noSelfInFile **/
/** @noResolution **/

export namespace unicorn {
    namespace core {
        export function install(package_table: string[]): boolean;
        export function uninstall(package_name: string): boolean;
    }
    namespace remote {
        export function install(): (pcm: string[]) => boolean;
    }
    namespace util {
        export function smartHttp(): (sUrl: string) => string;
        export function fileWrite(): (sContent: string, sPath: string) => boolean;
    }
}

