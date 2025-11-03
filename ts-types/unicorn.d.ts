/** @noSelfInFile **/
/** @noResolution **/

export interface PackageTableType {
    // v1.0.0 is what libunicornpkg currently supports
    unicornSpec: "v1.0.0";
    pkgType: "com.github" | "com.github.releases" | "com.gitlab" | "com.pastebin" | "org.bitbucket";
    name: string;
    desc?: string;
    maintainer?: string;
    licensing?: string;
    version?: string;
    script?: {
        preinstall?: string;
        postinstall?: string;
        preremove?: string;
        postremove?: string;
    };
    rel?: {
        depends?: string[];
        conflicts?: string[];
    };
    security?: { sha256?: Map<string, string> };
}

declare module "unicorn" {
    export namespace core {
        export function install(package: PackageTableType): boolean;
        export function uninstall(package_name: string): boolean;
    }
    export namespace remote {
        export function install(): (pcm: string[]) => boolean;
    }
    export namespace util {
        export function smartHttp(): (sUrl: string) => string;
        export function fileWrite(): (sContent: string, sPath: string) => boolean;
    }
}
