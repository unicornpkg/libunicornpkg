/** @noSelfInFile **/
/** @noResolution **/
declare module "unicorn.util" {
    export function smartHttp(): (sUrl: string) => string;
    export function fileWrite(): (sContent: string, sPath: string) => boolean;
}
