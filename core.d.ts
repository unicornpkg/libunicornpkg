/** @noSelfInFile **/
/** @noResolution **/
declare module "unicorn.core" {
    export function install(package_table: string[]): boolean;
    export function uninstall(package_name: string): boolean;
}
