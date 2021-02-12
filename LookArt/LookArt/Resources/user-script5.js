!function() {
    "use strict";
    function o() {
        try {
            return window.self === window.top
        } catch (e) {
            return !1
        }
    }
    window.__firefox__ || (window.__firefox__ = {});
    var n = !1,
        _ = null,
        t = null;
    function y(e) {
        n && alert(e)
    }
    function m(e) {
        if (!(e instanceof HTMLInputElement))
            return !1;
        var n = e.hasAttribute("type") ? e.getAttribute("type").toLowerCase() : e.type;
        return "text" == n || "email" == n || "url" == n || "tel" == n || "number" == n
    }
    function i(e, n) {
        var t = null,
            r = function(e, n) {
                for (var t = [], r = e.getElementsByTagName("input"), o = 0; o < r.length; o++) {
                    var i = r[o];
                    i instanceof HTMLInputElement && "password" == i.type && (n && !i.value || (t[t.length] = {
                        index: o,
                        element: i
                    }))
                }
                return 0 == t.length ? (y("(form ignored -- no password fields.)"), null) : 3 < t.length ? (y("(form ignored -- too many password fields. [ got ", t.length), null) : t
            }(e, n);
        if (!r)
            return [null, null, null];
        for (var o, i, a = e.getElementsByTagName("input"), s = r[0].index - 1; 0 <= s; s--) {
            var l = a[s];
            if (m(l)) {
                t = l;
                break
            }
        }
        if (t || y("(form -- no username field found)"), !n || 1 == r.length)
            return [t, r[0].element, null];
        var u = r[0].element.value,
            d = r[1].element.value,
            f = r[2] ? r[2].element.value : null;
        if (3 == r.length)
            if (u == d && d == f)
                i = r[0].element,
                o = null;
            else if (u == d)
                i = r[0].element,
                o = r[2].element;
            else if (d == f)
                o = r[0].element,
                i = r[2].element;
            else {
                if (u != f)
                    return y("(form ignored -- all 3 pw fields differ)"), [null, null, null];
                i = r[0].element,
                o = r[1].element
            }
        else
            u == d ? (i = r[0].element, o = null) : (o = r[0].element, i = r[1].element);
        return [t, i, o]
    }
    function s(e) {
        var n = e.style.visibility;
        if (n && "hidden" === n.toLowerCase())
            return !1;
        var t = e.style.display;
        return !(t && -1 < t.toLowerCase().indexOf("none"))
    }
    function l(e) {
        for (var n = document.forms, t = 0; t < n.length; t++) {
            var r = i(n[t], e);
            if (r[0] && r[1])
                return _ = r, n[t]
        }
        return _ = i(document.body, e), null
    }
    function r(e) {
        for (var n, t = null, r = e.querySelectorAll("a[href='javascript:;'],a[href='#'],a[href='javascript:void(0);'],button"), o = r.length, i = 0; i < o; ++i) {
            var a = r[i];
            if (s(a) && (-1 < (n = (n = a.innerHTML.toLowerCase()).replace(" ", "")).indexOf("login") || -1 < n.indexOf("登录") || -1 < n.indexOf("登 录") || -1 < n.indexOf("确定") || -1 < n.indexOf("登陆") || -1 < n.indexOf("登 陆"))) {
                t = a;
                break
            }
        }
        return t
    }
    function u() {
        return _ && _[0] && _[1]
    }
    var a = {
        _getRandomId: function() {
            return Math.round(Math.random() * (Number.MAX_VALUE - Number.MIN_VALUE) + Number.MIN_VALUE).toString()
        },
        _messages: ["RemoteLogins:loginsFound"],
        _requests: {},
        _takeRequest: function(e) {
            var n = e,
                t = this._requests[n.requestId];
            return this._requests[n.requestId] = void 0, t
        },
        _sendRequest: function(t, e) {
            var r = this._getRandomId();
            e.requestId = r,
            webkit.messageHandlers.loginsManagerMessageHandler.postMessage(e);
            var o = this;
            return new Promise(function(e, n) {
                t.promise = {
                    resolve: e,
                    reject: n
                },
                o._requests[r] = t
            })
        },
        receiveMessage: function(e) {
            if ("RemoteLogins:loginInject" != e.name) {
                var n = this._takeRequest(e);
                if (n)
                    switch (e.name) {
                    case "RemoteLogins:loginsFound":
                        n.promise.resolve({
                            form: n.form,
                            loginsFound: e.logins
                        });
                        break;
                    case "RemoteLogins:loginsAutoCompleted":
                        n.promise.resolve(e.logins)
                    }
                else if (u() && a._fillForm(!1, !1, !1, e.logins), o())
                    for (var t = window.frames, r = 0; r < t.length; r++)
                        t[r].postMessage(JSON.stringify(e), "*")
            } else
                a._fillForm(!0, !0, !0, e.logins)
        },
        _asyncFindLogins: function(e) {
            if (!u())
                return Promise.reject("No logins found");
            _[0].removeEventListener("blur", d),
            _[0].addEventListener("blur", d);
            var n = {
                form: _[0]
            };
            return this._sendRequest(n, {
                type: "request"
            })
        },
        onUsernameInput: function(e) {
            var n = e.target;
            if (n.value && u() && _[0] === n) {
                var t = this;
                this._asyncFindLogins({
                    showMasterPassword: !1
                }).then(function(e) {
                    t._fillForm(!0, !0, !1, e.loginsFound)
                }).then(null, y)
            }
        },
        _onFormSubmit: function() {
            if (l(!0), u()) {
                var e = document.documentURI;
                if (e) {
                    var n = document.documentURI,
                        t = _,
                        r = t[0],
                        o = t[1],
                        i = t[2];
                    if (null != o) {
                        var a = r ? {
                                name: r.name,
                                value: r.value
                            } : null,
                            s = {
                                name: o.name,
                                value: o.value
                            };
                        i && (i.name, i.value),
                        window.opener && window.opener.top;
                        webkit.messageHandlers.loginsManagerMessageHandler.postMessage({
                            type: "submit",
                            hostname: e,
                            username: a.value,
                            usernameField: a.name,
                            password: s.value,
                            passwordField: s.name,
                            formSubmitURL: n
                        })
                    }
                } else
                    y("(form submission ignored -- invalid hostname)")
            }
        },
        _fillForm: function(e, n, t, r) {
            var o = _,
                i = o[0],
                a = o[1];
            if (null == a)
                return [!1, r];
            if (a.disabled || a.readOnly)
                return y("not filling form, password field disabled or read-only"), [!1, r];
            var s = Number.MAX_VALUE,
                l = Number.MAX_VALUE;
            i && 0 <= i.maxLength && (s = i.maxLength),
            0 <= a.maxLength && (l = a.maxLength);
            var u = (r = function(e, n) {
                var t,
                    r,
                    o;
                if (null == e)
                    throw new TypeError(" array is null or not defined");
                var i = Object(e),
                    a = i.length >>> 0;
                if ("function" != typeof n)
                    throw new TypeError(n + " is not a function");
                1 < arguments.length && (t = e);
                r = new Array(a),
                o = 0;
                for (; o < a;) {
                    var s,
                        l;
                    o in i && (s = i[o], l = n.call(t, s, o, i), r[o] = l),
                    o++
                }
                return r
            }(r, function(e) {
                return {
                    hostname: e.hostname,
                    formSubmitURL: e.formSubmitURL,
                    httpReal: e.httpRealm,
                    username: e.username,
                    password: e.password,
                    usernameField: e.usernameField,
                    passwordField: e.passwordField
                }
            })).filter(function(e) {
                var n = e.username.length <= s && e.password.length <= l;
                return n || y("Ignored", e.username), n
            }, this);
            if (0 == u.length)
                return [!1, r];
            if (a.value && !e)
                return [!"existingPassword", r];
            var d = null;
            if (!t && i && (i.value || i.disabled || i.readOnly)) {
                var f = i.value.toLowerCase();
                if ((v = u.filter(function(e) {
                    return e.username.toLowerCase() == f
                })).length) {
                    for (var m = 0; m < v.length; m++) {
                        var c = v[m];
                        c.username == i.value && (d = c)
                    }
                    d = d || v[0]
                } else
                    "existingUsername",
                    y("Password not filled. None of the stored logins match the username already present.")
            } else if (1 == u.length)
                d = u[0];
            else {
                var v;
                v = i ? u.filter(function(e) {
                    return e.username
                }) : u.filter(function(e) {
                    return !e.username
                }),
                d = v[0]
            }
            var g = !1;
            if (d) {
                if (i) {
                    var w = i.disabled || i.readOnly,
                        h = d.username != i.value,
                        p = n && h && i.value.toLowerCase() == d.username.toLowerCase();
                    w || p || !h || (i.value = d.username, b(i, "keydown", 40), b(i, "keyup", 40))
                }
                a.value != d.password && (a.value = "", window.setTimeout(function() {
                    a.value = d.password,
                    b(a, "keydown", 40),
                    b(a, "keyup", 40)
                }, 300)),
                g = !0
            }
            return [g, r]
        }
    };
    function d(e) {
        a.onUsernameInput(e)
    }
    var e = document.body ? document.body : document;
    function f(e) {
        if (!u()) {
            for (var n = 0; n < e.length; n++) {
                var t = e[n];
                if ("INPUT" === t.nodeName)
                    return void v();
                t.hasChildNodes() && f(t.childNodes)
            }
            return !1
        }
    }
    function c(e) {
        "click" == e.type && e.target === t && a._onFormSubmit()
    }
    function v() {
        try {
            var e,
                n = l(!1);
            if (u())
                if (n && (e = r(n)), e = e || r(document.body))
                    ((t = e).parentNode ? e.parentNode : e).addEventListener("click", c, !0);
            a._asyncFindLogins({}).then(function(e) {
                a._fillForm(!1, !1, !1, e.loginsFound)
            }).then(null, y)
        } catch (e) {
            y(e)
        }
    }
    function b(e, n, t) {
        var r = document.createEvent("KeyboardEvent");
        r.initKeyboardEvent(n, !0, !0, document.defaultView, t),
        e.dispatchEvent(r)
    }
    new MutationObserver(function(e) {
        for (var n = 0; n < e.length; ++n)
            f(e[n].addedNodes)
    }).observe(e, {
        attributes: !1,
        childList: !0,
        characterData: !1,
        subtree: !0
    }),
    window.addEventListener("load", v),
    o() && (window.__firefox__.loginStopLoading = v, window.__firefox__.searchLoginField = function() {
        var e = document.activeElement;
        return "input" !== e.tagName.toLowerCase() ? null : e === _[0] || e === _[1] ? "true" : void 0
    }),
    window.addEventListener("submit", function(e) {
        try {
            a._onFormSubmit()
        } catch (e) {
            y(e)
        }
    }),
    window.__firefox__ || (window.__firefox__ = {}),
    window.__firefox__.logins = new function() {
        this.inject = function(e) {
            try {
                a.receiveMessage(e)
            } catch (e) {}
        }
    },
    o() || window.addEventListener("message", function(e) {
        "string" == typeof e.data && -1 != e.data.indexOf("RemoteLogins:loginsFound") && a.receiveMessage(JSON.parse(e.data))
    })
}();
