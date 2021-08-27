/**
 * @file Provides <module>.
 * @summary Module <module> does stuff.
 * @module <module>
 * @requires <dependencies>
 * @author Yuri Norwood <https://github.com/yuri-norwood>
 * @license Unlicense
 */
(function (root, factory) {
    "use strict";

    if (typeof(define) === "function" && define.amd) {
        // AMD
        define("<module>", [ /* <dependency> */ ], factory);
    } else {
        // Browser
        root.exports = factory(root.dependency);
    }
})(typeof self !== "undefined" ? self : this, function () {
"use strict";

/**
 * @alias module:<module>
 */
return {
};
});
