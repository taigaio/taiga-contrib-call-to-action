###
# Copyright (C) 2014-2017 Andrey Antukh <niwi@niwi.nz>
# Copyright (C) 2014-2017 Jesús Espino Garcia <jespinog@gmail.com>
# Copyright (C) 2014-2017 David Barragán Merino <bameda@dbarragan.com>
# Copyright (C) 2014-2017 Alejandro Alonso <alejandro.alonso@kaleidos.net>
# Copyright (C) 2014-2017 Juan Francisco Alcántara <juanfran.alcantara@kaleidos.net>
# Copyright (C) 2014-2017 Xavi Julian <xavier.julian@kaleidos.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: call-to-action.coffee
###

locales = {
    "en": {
        "BEGIN_PROJECT": "Begin a project like this completely<br /><b>FREE</b>",
        "REGISTER": "Register",
        "DISMISS": "dismiss",
    },
    "es": {
        "BEGIN_PROJECT": "Comienza un proyecto como este completamente<br /><b>GRATIS</b>",
        "REGISTER": "Registrate",
        "DISMISS": "descartar",
    }
}

template = """
<call-to-action>
    <div class="close">{{translate("DISMISS")}}</div>

    <div class="center">
        <p ng-bind-html='translate("BEGIN_PROJECT")'></p>
        <a class="register button-green">{{translate("REGISTER")}}</a>
    </div>
</call-to-action>
"""

CallToActionDirective = ($compile, $config, $translate, $location, $analytics) ->
    setCookie = (cname, cvalue, exdays) ->
        d = new Date()
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000))
        expires = "expires=" + d.toUTCString()
        document.cookie = cname + "=" + cvalue + "; " + expires

    getCookie = (cname) ->
        name = cname + "="
        ca = document.cookie.split(';')

        for c in ca
            while (c.charAt(0) == ' ')
                c = c.substring(1)

            if (c.indexOf(name) != -1)
                return c.substring(name.length, c.length)

    translate = (locale, text) ->
        try
            return locales[locale][text]
        catch e
            return locales["en"][text]

    link = ($scope, $el, $attrs) ->
        $scope.$on "loader:end", () ->
            if $scope.user
                return

            if getCookie('callToAction') == '1'
                return

            $scope.$apply () ->
                $scope.translate = translate.bind(this, $translate.use())
                callToActionBox = $compile($(template))($scope)

                timelineEl = $el.find('.project-data .timeline')
                timelineEl.prepend(callToActionBox)

                timelineEl.find('.close').on 'click', (e) ->
                    e.preventDefault()
                    e.stopPropagation()

                    callToActionBox.fadeOut('fast')
                    setCookie('callToAction', 1, 730)

                timelineEl.find('call-to-action').on 'click', (e) ->
                    e.preventDefault()
                    $analytics.trackEvent("call-to-action", "register-click", "click the register button in the call to action", 1)
                    $location.url("/register")

    return {
        restrict: "E"
        link: link
    }

module = angular.module('callToActionPlugin', [])
module.directive("body", ["$compile", "$tgConfig", "$translate", "$tgLocation", "$tgAnalytics", CallToActionDirective])
