!function() {
    function lastInteger(e) {
        var t = e.match(/[0-9]+/g);
        return t ? parseInt(t[t.length - 1]) : NaN
    }
    function escapeCharacters(e, t) {
        for (var n = !1, i = t.length, r = 0; r < i; ++r)
            if (-1 !== e.indexOf(t.charAt(r))) {
                n = !0;
                break
            }
        if (!n)
            return e;
        var a = "",
            l = e.length;
        for (r = 0; r < l; ++r)
            -1 !== t.indexOf(e.charAt(r)) && (a += "\\"),
            a += e.charAt(r);
        return a
    }
    function escapeForRegExp(e) {
        return escapeCharacters(e, "^[]{}()\\.$*+?|")
    }
    function characterNeedsScoreMultiplier(e) {
        if (!e || 0 === e.length)
            return !1;
        var t = e.charCodeAt(0);
        return 11904 < t && t < 12031 || (12352 < t && t < 12543 || (12736 < t && t < 19903 || (19968 < t && t < 40959 || (44032 < t && t < 55215 || (63744 < t && t < 64255 || (65072 < t && t < 65103 || (131072 < t && t < 173791 || 194560 < t && t < 195103)))))))
    }
    function domDistance(e, t, n) {
        for (var i = [], r = e; r;)
            i.unshift(r),
            r = r.parentNode;
        var a = [];
        for (r = t; r;)
            a.unshift(r),
            r = r.parentNode;
        for (var l = Math.min(i.length, a.length), o = Math.abs(i.length - a.length), s = l; 0 <= s && i[s] !== a[s]; --s)
            if (o += 2, n && n <= o)
                return n;
        return o
    }
    function fontSizeFromComputedStyle(e, t) {
        var n = parseInt(e.fontSize);
        return isNaN(n) && (n = t || BaseFontSize), n
    }
    function contentTextStyleForNode(e, t) {
        function n(e) {
            if (isNodeWhitespace(e))
                return null;
            var t = getComputedStyle(e.parentNode);
            return "none" !== t.float ? null : t
        }
        for (var i = e.evaluate("descendant::text()[not(parent::h1) and not(parent::h2) and not(parent::h3) and not(parent::h4) and not(parent::h5) and not(parent::h6)]", t, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null), r = i.snapshotLength, a = 0; a < r; ++a) {
            for (var l = i.snapshotItem(a), o = !1, s = l.parentElement; s !== t; s = s.parentElement)
                if (NegativeRegEx.test(s.className)) {
                    o = !0;
                    break
                }
            if (!o) {
                var c = n(l);
                if (c)
                    return c
            }
        }
        return null
    }
    function isNodeWhitespace(e) {
        return !(!e || e.nodeType !== Node.TEXT_NODE) && !/\S/.test(e.data)
    }
    function removeWhitespace(e) {
        return e.replace(/\s+/g, "")
    }
    function isElementNode(e) {
        return !(!e || e.nodeType !== Node.ELEMENT_NODE)
    }
    function computedStyleIndicatesElementIsInvisibleDueToClipping(e) {
        if ("absolute" !== e.position)
            return !1;
        var t = e.clip.match(/^rect\((\d+px|auto), (\d+px|auto), (\d+px|auto), (\d+px|auto)\)$/);
        if (!t || 5 !== t.length)
            return !1;
        var n = t.map(function(e) {
                return parseInt(e)
            }),
            i = n[1];
        isNaN(i) && (i = 0);
        var r = n[2],
            a = n[3],
            l = n[4];
        return isNaN(l) && (l = 0), a <= i || l <= r
    }
    function isElementVisible(e) {
        var t = getComputedStyle(e);
        if ("visible" !== t.visibility || "none" === t.display)
            return !1;
        if (cachedElementBoundingRect(e).height)
            return !0;
        var n = document.createRange();
        return n.selectNode(e), !!n.getBoundingClientRect().height
    }
    function isElementPositionedOffScreen(e) {
        var t = cachedElementBoundingRect(e);
        return !(!t.height || !t.width) && (t.bottom <= 0 || t.right <= 0)
    }
    function elementDepth(e) {
        for (var t = 0; e; e = e.parentElement)
            t++;
        return t
    }
    function depthOfElementWithinElement(e, t) {
        for (var n = 0; e !== t; e = e.parentElement)
            n++;
        return n
    }
    function nearestAncestorElementWithTagName(e, t) {
        for (; e = e.parentElement;)
            if (e.tagName === t)
                return e;
        return null
    }
    function cachedElementBoundingRect(e) {
        if (e._cachedElementBoundingRect)
            return e._cachedElementBoundingRect;
        var t = e.getBoundingClientRect();
        return ReaderArticleFinderJS._elementsWithCachedBoundingRects.push(e), ReaderArticleFinderJS._cachedScrollX || ReaderArticleFinderJS._cachedScrollY ? e._cachedElementBoundingRect = {
            top: t.top + ReaderArticleFinderJS._cachedScrollY,
            right: t.right + ReaderArticleFinderJS._cachedScrollX,
            bottom: t.bottom + ReaderArticleFinderJS._cachedScrollY,
            left: t.left + ReaderArticleFinderJS._cachedScrollX,
            width: t.width,
            height: t.height
        } : e._cachedElementBoundingRect = t, e._cachedElementBoundingRect
    }
    function clearCachedElementBoundingRects() {
        for (var e = ReaderArticleFinderJS._elementsWithCachedBoundingRects, t = e.length, n = 0; n < t; ++n)
            e[n]._cachedElementBoundingRect = null;
        ReaderArticleFinderJS._elementsWithCachedBoundingRects = []
    }
    function innerTextOrTextContent(e) {
        var t = e.innerText;
        return /\S/.test(t) || (t = e.textContent), t
    }
    function levenshteinDistance(e, t) {
        for (var n = e.length, i = t.length, r = new Array(n + 1), a = 0; a < n + 1; ++a)
            r[a] = new Array(i + 1),
            r[a][0] = a;
        for (var l = 0; l < i + 1; ++l)
            r[0][l] = l;
        for (l = 1; l < i + 1; ++l)
            for (a = 1; a < n + 1; ++a)
                if (e[a - 1] === t[l - 1])
                    r[a][l] = r[a - 1][l - 1];
                else {
                    var o = r[a - 1][l] + 1,
                        s = r[a][l - 1] + 1,
                        c = r[a - 1][l - 1] + 1;
                    r[a][l] = Math.min(o, s, c)
                }
        return r[n][i]
    }
    function stringSimilarity(e, t) {
        var n = Math.max(e.length, t.length);
        return n ? (n - levenshteinDistance(e, t)) / n : 0
    }
    function stringsAreNearlyIdentical(e, t) {
        return e === t || stringSimilarity(e, t) > StringSimilarityToDeclareStringsNearlyIdentical
    }
    function elementIsCommentBlock(e) {
        if (/(^|\s)comment/.test(e.className))
            return !0;
        var t = e.getAttribute("id");
        return !(!t || 0 !== t.indexOf("comment"))
    }
    function elementLooksLikeEmbeddedTweet(e) {
        if ("IFRAME" !== e.tagName)
            return !1;
        if (!e.contentDocument)
            return !1;
        var t = e.contentDocument.documentElement,
            n = 0,
            i = t.querySelector("blockquote");
        return i && /http.+twitter.com.*status.*[0-9]+/i.test(i.getAttribute("cite")) && ++n, e.classList.contains("twitter-tweet") && ++n, t.querySelector("[data-iframe-title='Embedded Tweet']") && ++n, t.querySelector("[data-tweet-id]") && ++n, 2 < n
    }
    function elementLooksLikePartOfACarousel(e) {
        for (var t = /carousel-|carousel_|-carousel|_carousel/, n = e, i = 0; i < 3; ++i) {
            if (!n)
                return !1;
            if (t.test(n.className) || t.test(n.getAttribute("data-analytics")))
                return !0;
            n = n.parentElement
        }
    }
    function shouldPruneIframe(e, t) {
        return !HostnamesKnownToContainEmbeddableMediaRegex.test(anchorForURL(e.src, t).hostname) && !elementLooksLikeEmbeddedTweet(e.originalElement)
    }
    function languageScoreMultiplierForTextNodes(e) {
        if (!e || !e.length)
            return 1;
        for (var t = Math.min(e.length, DefaultNumberOfTextNodesToCheckForLanguageMultiplier), n = 0, i = 0, r = 0; r < t; r++) {
            for (var a = e[r].nodeValue.trim(), l = Math.min(a.length, NumberOfCharactersPerTextNodeToEvaluateForLanguageMultiplier), o = 0; o < l; o++)
                characterNeedsScoreMultiplier(a[o]) && n++;
            i += l
        }
        return i * MinimumRatioOfCharactersForLanguageMultiplier <= n ? ScoreMultiplierForChineseJapaneseKorean : 1
    }
    function scoreMultiplierForElementTagNameAndAttributes(e) {
        for (var t = 1, n = e; n; n = n.parentElement) {
            var i = n.getAttribute("id");
            i && (ArticleRegEx.test(i) && (t += ArticleMatchBonus), CommentRegEx.test(i) && (t -= CommentMatchPenalty));
            var r = n.className;
            r && (ArticleRegEx.test(r) && (t += ArticleMatchBonus), CommentRegEx.test(r) && (t -= CommentMatchPenalty)),
            "ARTICLE" === n.tagName && (t += ArticleMatchBonus)
        }
        return t < 0 ? 0 : t
    }
    function elementsFromPoint(e, t) {
        for (var n, i, r, a = [], l = []; (n = document.elementFromPoint(e, t)) && -1 === a.indexOf(n) && null != n;)
            a.push(n),
            l.push({
                value: n.style.getPropertyValue("pointer-events"),
                priority: n.style.getPropertyPriority("pointer-events")
            }),
            n.style.setProperty("pointer-events", "none", "important");
        for (i = l.length; r = l[--i];)
            a[i].style.setProperty("pointer-events", r.value ? r.value : "", r.priority);
        return a
    }
    function userVisibleURLString(e) {
        return "undefined" != typeof ReaderArticleFinderJSController && ReaderArticleFinderJSController.userVisibleURLString ? ReaderArticleFinderJSController.userVisibleURLString(e) : e
    }
    function anchorForURL(e, t) {
        var n = t.createElement("a");
        return n.href = e, n
    }
    function anchorLinksToAttachment(e) {
        return /\battachment\b/i.test(e.getAttribute("rel"))
    }
    function anchorLinksToTagOrCategoryPage(e) {
        return /\bcategory|tag\b/i.test(e.getAttribute("rel"))
    }
    function elementsHaveSameTagAndClassNames(e, t) {
        return e.tagName === t.tagName && e.className === t.className
    }
    function selectorForElement(e) {
        for (var t = e.tagName, n = e.classList, i = n.length, r = 0; r < i; r++)
            t += "." + n[r];
        return t
    }
    function elementFingerprintForDepth(e, t) {
        var o = " / ",
            s = " \\",
            c = " | ";
        return function e(t, n) {
            if (!t)
                return "";
            var i = [];
            i.push(selectorForElement(t));
            var r = t.children,
                a = r.length;
            if (a && 0 < n) {
                i.push(o);
                for (var l = 0; l < a; ++l)
                    i.push(e(r[l], n - 1)),
                    l !== a - 1 && i.push(c);
                i.push(s)
            }
            return i.join("")
        }(e, t)
    }
    function childrenOfParentElement(e) {
        var t = e.parentElement;
        return t ? t.children : []
    }
    function arrayOfKeysAndValuesOfObjectSortedByValueDescending(e) {
        var t = [];
        for (var n in e)
            e.hasOwnProperty(n) && t.push({
                key: n,
                value: e[n]
            });
        return t.sort(function(e, t) {
            return t.value - e.value
        }), t
    }
    function walkElementSubtree(e, t, n) {
        if (!(t < 0)) {
            for (var i = e.children, r = i.length, a = t - 1, l = 0; l < r; ++l)
                walkElementSubtree(i[l], a, n);
            n(e, t)
        }
    }
    function childrenWithParallelStructure(e) {
        var t = e.children;
        if (!t)
            return [];
        var n = t.length;
        if (!n)
            return [];
        for (var i = {}, r = 0; r < n; ++r) {
            var a = t[r];
            if (!CandidateTagNamesToIgnore[a.tagName] && a.className)
                for (var l = a.classList, o = l.length, s = 0; s < o; ++s) {
                    (u = i[h = l[s]]) ? u.push(a) : i[h] = [a]
                }
        }
        var c = Math.floor(n / 2);
        for (var h in i) {
            var u;
            if ((u = i[h]).length > c)
                return u
        }
        return []
    }
    var ReaderMinimumScore = 1600,
        ReaderMinimumAdvantage = 15,
        ArticleMinimumScoreDensity = 4.25,
        BlacklistedHostsAllowedPathRegexMap = {
            "www.apple.com": /^\/([a-z]{2,4}\/){0,2}pr\/|^\/hotnews\//
        },
        ListOfHostnameAndTrustedArticleNodeSelectorPairs = [[/.*\.apple.com$/, "article"]],
        CandidateMinimumWidth = 280,
        CandidateMinimumHeight = 295,
        CandidateMinimumArea = 17e4,
        CandidateMaximumTop = 1300,
        CandidateMinimumWidthPortionForIndicatorElements = .5,
        CandidateMinumumListItemLineCount = 4,
        CandidateTagNamesToIgnore = {
            A: 1,
            EMBED: 1,
            FORM: 1,
            HTML: 1,
            IFRAME: 1,
            OBJECT: 1,
            OL: 1,
            OPTION: 1,
            SCRIPT: 1,
            STYLE: 1,
            svg: 1,
            UL: 1
        },
        PrependedArticleCandidateMinimumHeight = 50,
        AppendedArticleCandidateMinimumHeight = 200,
        AppendedArticleCandidateMaximumVerticalDistanceFromArticle = 150,
        StylisticClassNames = {
            justfy: 1,
            justify: 1,
            left: 1,
            right: 1,
            small: 1
        },
        CommentRegEx = /comment|meta|footer|footnote/,
        CommentMatchPenalty = .75,
        ArticleRegEx = /(?:(?:^|\s)(?:(post|hentry|entry)[-_]?(?:content|text|body)?|article[-_]?(?:content|text|body|page)?)(?:\s|$))/i,
        ArticleMatchBonus = .5,
        DensityExcludedElementSelector = "#disqus_thread, #comments, .userComments",
        AttributesToRemoveRegEx = /^on|^id$|^class$|^style$/,
        PositiveRegEx = /article|body|content|entry|hentry|page|pagination|post|text/i,
        NegativeRegEx = /advertisement|breadcrumb|combx|comment|contact|disqus|footer|link|meta|mod-conversations|promo|related|scroll|share|shoutbox|sidebar|social|sponsor|subscribe|tags|toolbox|widget|_ad$/i,
        VeryPositiveClassNameRegEx = /instapaper_body/,
        VeryNegativeClassNameRegEx = /instapaper_ignore/,
        SharingRegex = /email|print|rss|digg|slashdot|delicious|reddit|share/i,
        HostnamesKnownToContainEmbeddableMediaRegex = /youtube|vimeo|dailymotion/,
        MinimumAverageDistanceBetweenHRElements = 400,
        MinimumAverageDistanceBetweenHeaderElements = 400,
        PortionOfCandidateHeightToIgnoreForHeaderCheck = .1,
        DefaultNumberOfTextNodesToCheckForLanguageMultiplier = 3,
        NumberOfCharactersPerTextNodeToEvaluateForLanguageMultiplier = 12,
        MinimumRatioOfCharactersForLanguageMultiplier = .5,
        ScoreMultiplierForChineseJapaneseKorean = 3,
        MinimumContentMediaHeight = 150,
        MinimumContentMediaWidthToArticleWidthRatio = .25,
        MaximumContentMediaAreaToArticleAreaRatio = .2,
        LinkContinueMatchRegEx = /continue/gi,
        LinkNextMatchRegEx = /next/gi,
        LinkPageMatchRegEx = /page/gi,
        LinkListItemBonus = 5,
        LinkPageMatchBonus = 10,
        LinkNextMatchBonus = 15,
        LinkContinueMatchBonus = 15,
        LinkNextOrdinalValueBase = 3,
        LinkMismatchValueBase = 2,
        LinkMatchWeight = 200,
        LinkMaxVerticalDistanceFromArticle = 200,
        LinkVerticalDistanceFromArticleWeight = 150,
        LinkCandidateXPathQuery = "descendant-or-self::*[(not(@id) or (@id!='disqus_thread' and @id!='comments')) and (not(@class) or @class!='userComments')]/a",
        LinkDateRegex = /\D(?:\d\d(?:\d\d)?[\-\/](?:10|11|12|0?[1-9])[\-\/](?:30|31|[12][0-9]|0?[1-9])|\d\d(?:\d\d)?\/(?:10|11|12|0[1-9])|(?:10|11|12|0?[1-9])\-(?:30|31|[12][0-9]|0?[1-9])\-\d\d(?:\d\d)?|(?:30|31|[12][0-9]|0?[1-9])\-(?:10|11|12|0?[1-9])\-\d\d(?:\d\d)?)\D/,
        LinkURLSearchParameterKeyMatchRegex = /(page|^p$|^pg$)/i,
        LinkURLPageSlashNumberMatchRegex = /\/.*page.*\/\d+/i,
        LinkURLSlashDigitEndMatchRegex = /\/\d+\/?$/,
        LinkURLArchiveSlashDigitEndMatchRegex = /archives?\/\d+\/?$/,
        LinkURLBadSearchParameterKeyMatchRegex = /author|comment|feed|id|nonce|related/i,
        LinkURLSemanticMatchBonus = 100,
        LinkMinimumURLSimilarityRatio = .75,
        HeaderMinimumDistanceFromArticleTop = 200,
        HeaderLevenshteinDistanceToLengthRatio = .75,
        MinimumRatioOfListItemsBeingRelatedToSharingToPruneEntireList = .5,
        FloatMinimumHeight = 130,
        ImageSizeTiny = 32,
        ToleranceForLeadingImageWidthToArticleWidthForFullWidthPresentation = 50,
        MaximumFloatWidth = 325,
        AnchorImageMinimumWidth = 100,
        AnchorImageMinimumHeight = 100,
        MinimumHeightForImagesAboveTheArticleTitle = 50,
        MainImageMinimumWidthAndHeight = 83,
        BaseFontSize = 16,
        BaseLineHeightRatio = 1.125,
        MaximumExactIntegralValue = 9007199254740992,
        TitleCandidateDepthScoreMultiplier = .1,
        DocumentPositionDisconnected = 1,
        DocumentPositionPreceding = 2,
        DocumentPositionFollowing = 4,
        DocumentPositionContains = 8,
        DocumentPositionContainedBy = 16,
        TextNodeLengthPower = 1.25,
        KnownImageLazyLoadingAttributes = {
            "data-lazy-src": 1,
            "data-original": 1,
            "data-src": 1,
            "original-src": 1,
            "rel:bf_image_src": 1
        },
        StringSimilarityToDeclareStringsNearlyIdentical = .97;
    CandidateElement = function(e, t) {
        this.element = e,
        this.contentDocument = t,
        this.textNodes = this.usableTextNodesInElement(this.element),
        this.rawScore = this.calculateRawScore(),
        this.tagNameAndAttributesScoreMultiplier = this.calculateElementTagNameAndAttributesScoreMultiplier(),
        this.languageScoreMultiplier = 0,
        this.depthInDocument = 0
    },
    CandidateElement.extraArticleCandidateIfElementIsViable = function(e, t, n, i) {
        var r = cachedElementBoundingRect(e),
            a = cachedElementBoundingRect(t.element);
        if ((i && r.height < PrependedArticleCandidateMinimumHeight || !i && r.height < AppendedArticleCandidateMinimumHeight) && e.childElementCount && e.querySelectorAll("*").length !== e.querySelectorAll("a, b, strong, i, em, u, span").length)
            return null;
        if (i) {
            if (r.bottom > a.top)
                return null
        } else if (r.top < a.bottom)
            return null;
        if (!i) {
            var l = r.top - a.bottom;
            if (AppendedArticleCandidateMaximumVerticalDistanceFromArticle < l)
                return null
        }
        if (r.left > a.right || r.right < a.left)
            return null;
        if (elementLooksLikePartOfACarousel(e))
            return null;
        var o = new CandidateElement(e, n);
        return o.isPrepended = i, o
    },
    CandidateElement.candidateIfElementIsViable = function(e, t, n) {
        var i = cachedElementBoundingRect(e);
        return i.width < CandidateMinimumWidth || i.height < CandidateMinimumHeight ? null : i.width * i.height < CandidateMinimumArea ? null : !n && i.top > CandidateMaximumTop ? null : CandidateElement.candidateElementAdjustedHeight(e) < CandidateMinimumHeight ? null : new CandidateElement(e, t)
    },
    CandidateElement.candidateElementAdjustedHeight = function(e) {
        for (var t = cachedElementBoundingRect(e), n = t.height, i = e.getElementsByTagName("form"), r = i.length, a = 0; a < r; ++a) {
            var l = cachedElementBoundingRect(i[a]);
            l.width > t.width * CandidateMinimumWidthPortionForIndicatorElements && (n -= l.height)
        }
        var o = e.querySelectorAll("ol, ul"),
            s = o.length,
            c = null;
        for (a = 0; a < s; ++a) {
            var h = o[a];
            if (!(c && c.compareDocumentPosition(h) & DocumentPositionContainedBy)) {
                var u = h.getElementsByTagName("li"),
                    d = u.length,
                    m = cachedElementBoundingRect(h);
                if (d) {
                    var g = m.height / d,
                        f = getComputedStyle(u[0]),
                        p = parseInt(f.lineHeight);
                    if (isNaN(p))
                        p = fontSizeFromComputedStyle(f) * BaseLineHeightRatio;
                    m.width > t.width * CandidateMinimumWidthPortionForIndicatorElements && g / p < CandidateMinumumListItemLineCount && (n -= m.height, c = h)
                } else
                    n -= m.height
            }
        }
        return n
    },
    CandidateElement.prototype = {
        calculateRawScore: function() {
            for (var e = 0, t = this.textNodes, n = t.length, i = 0; i < n; ++i)
                e += this.rawScoreForTextNode(t[i]);
            return e
        },
        calculateElementTagNameAndAttributesScoreMultiplier: function() {
            return scoreMultiplierForElementTagNameAndAttributes(this.element)
        },
        calculateLanguageScoreMultiplier: function() {
            0 === this.languageScoreMultiplier && (this.languageScoreMultiplier = languageScoreMultiplierForTextNodes(this.textNodes))
        },
        depth: function() {
            return this.depthInDocument || (this.depthInDocument = elementDepth(this.element)), this.depthInDocument
        },
        finalScore: function() {
            return this.calculateLanguageScoreMultiplier(), this.basicScore() * this.languageScoreMultiplier
        },
        basicScore: function() {
            return this.rawScore * this.tagNameAndAttributesScoreMultiplier
        },
        scoreDensity: function() {
            var e = 0,
                t = this.element.querySelector(DensityExcludedElementSelector);
            t && (e = t.clientWidth * t.clientHeight);
            for (var n = this.element.children || [], i = n.length, r = 0; r < i; ++r) {
                var a = n[r];
                elementIsCommentBlock(a) && (e += a.clientWidth * a.clientHeight)
            }
            var l = cachedElementBoundingRect(this.element).width * cachedElementBoundingRect(this.element).height,
                o = l * MaximumContentMediaAreaToArticleAreaRatio,
                s = cachedElementBoundingRect(this.element).width * MinimumContentMediaWidthToArticleWidthRatio,
                c = this.element.querySelectorAll("img, object, video"),
                h = c.length;
            for (r = 0; r < h; ++r) {
                var u = cachedElementBoundingRect(c[r]);
                if (u.width >= s && u.height > MinimumContentMediaHeight) {
                    var d = u.width * u.height;
                    d < o && (e += d)
                }
            }
            var m = this.basicScore(),
                g = l - e,
                f = this.textNodes.length,
                p = 0,
                v = 0;
            for (r = 0; r < f; ++r) {
                var E = this.textNodes[r].parentNode;
                E && (v += fontSizeFromComputedStyle(getComputedStyle(E)), p++)
            }
            var N = BaseFontSize;
            return p && (N = v /= p), this.calculateLanguageScoreMultiplier(), m / g * 1e3 * (N / BaseFontSize) * this.languageScoreMultiplier
        },
        usableTextNodesInElement: function(e) {
            var a = [];
            if (!e)
                return a;
            function t(e) {
                for (var t = o.evaluate("text()|*/text()|*/a/text()|*/li/text()|*/span/text()|*/em/text()|*/i/text()|*/strong/text()|*/b/text()|*/font/text()|blockquote/*/text()|div[count(./p)=count(./*)]/p/text()", e, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null), n = t.snapshotLength, i = 0; i < n; ++i) {
                    var r = t.snapshotItem(i);
                    l[r.parentNode.tagName] || r._countedTextNode || isNodeWhitespace(r) || (r._countedTextNode = !0, a.push(r))
                }
            }
            var l = {
                    A: 1,
                    DD: 1,
                    DT: 1,
                    NOSCRIPT: 1,
                    OL: 1,
                    OPTION: 1,
                    PRE: 1,
                    SCRIPT: 1,
                    STYLE: 1,
                    TD: 1,
                    UL: 1,
                    IFRAME: 1
                },
                o = this.contentDocument;
            t(e);
            for (var n = childrenWithParallelStructure(e), i = n.length, r = 0; r < i; ++r) {
                t(n[r])
            }
            var s = a.length;
            for (r = 0; r < s; ++r)
                delete a[r]._countedTextNode;
            return a
        },
        addTextNodesFromCandidateElement: function(e) {
            for (var t = this.textNodes.length, n = 0; n < t; ++n)
                this.textNodes[n].alreadyCounted = !0;
            var i = e.textNodes,
                r = i.length;
            for (n = 0; n < r; ++n)
                i[n].alreadyCounted || this.textNodes.push(i[n]);
            for (t = this.textNodes.length, n = 0; n < t; ++n)
                this.textNodes[n].alreadyCounted = null;
            this.rawScore = this.calculateRawScore()
        },
        rawScoreForTextNode: function(e) {
            if (!e)
                return 0;
            var t = e.length;
            if (t < 20)
                return 0;
            var n = e.parentNode;
            if (!isElementVisible(n))
                return 0;
            for (var i = 1; n && n !== this.element;)
                i -= .1,
                n = n.parentNode;
            return Math.pow(t * i, TextNodeLengthPower)
        },
        shouldDisqualifyDueToScoreDensity: function() {
            return this.scoreDensity() < ArticleMinimumScoreDensity
        },
        shouldDisqualifyDueToHorizontalRuleDensity: function() {
            for (var e = this.element.getElementsByTagName("hr"), t = e.length, n = 0, i = cachedElementBoundingRect(this.element), r = .7 * i.width, a = 0; a < t; ++a)
                e[a].clientWidth > r && n++;
            if (n && i.height / n < MinimumAverageDistanceBetweenHRElements)
                return !0;
            return !1
        },
        shouldDisqualifyDueToHeaderDensity: function() {
            var e = this.contentDocument.evaluate("(h1|h2|h3|h4|h5|h6|*/h1|*/h2|*/h3|*/h4|*/h5|*/h6)[a[@href]]", this.element, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null),
                t = e.snapshotLength;
            if (2 < t) {
                for (var n = 0, i = cachedElementBoundingRect(this.element), r = i.height * PortionOfCandidateHeightToIgnoreForHeaderCheck, a = 0; a < t; ++a) {
                    var l = cachedElementBoundingRect(e.snapshotItem(a));
                    l.top - i.top > r && i.bottom - l.bottom > r && n++
                }
                if (i.height / n < MinimumAverageDistanceBetweenHeaderElements)
                    return !0
            }
            return !1
        },
        shouldDisqualifyDueToSimilarElements: function(e) {
            function t(e) {
                return !!{
                    H1: 1,
                    H2: 1,
                    H3: 1,
                    H4: 1,
                    H5: 1,
                    H6: 1
                }[e.tagName]
            }
            function n(e, t) {
                if (!e || !t)
                    return !1;
                return e.className ? e.className === t.className : elementFingerprintForDepth(e, 1) === elementFingerprintForDepth(t, 1)
            }
            var i = /clearfix/i,
                r = "h1, h2, h3, h4, h5, h6",
                a = this.element;
            if ("LI" === a.tagName || "DD" === a.tagName)
                if ("LI" === a.tagName && 480 < a.getBoundingClientRect().height)
                    a.removeAttribute("style");
                else
                    for (var l = a.parentNode, o = l.children.length, s = 0; s < o; ++s) {
                        if ((v = l.children[s]).tagName === a.tagName && v.className === a.className && v !== a)
                            return !0
                    }
            var c = a.getAttribute("class");
            if (c || (a = a.parentElement) && ((c = a.getAttribute("class")) || (a = a.parentElement) && (c = a.getAttribute("class"))), c) {
                var h,
                    u = (e = e || []).length;
                for (s = 0; s < u; ++s)
                    e[s].element.candidateElement = e[s];
                try {
                    var d = c.split(" "),
                        m = "";
                    for (s = 0; s < d.length; ++s)
                        i.test(d[s]) || d[s].length && (m += "." + d[s]);
                    h = this.contentDocument.querySelectorAll(m)
                } catch (e) {
                    h = []
                }
                var g = !1,
                    f = elementDepth(a),
                    p = h.length;
                for (s = 0; s < p; ++s) {
                    var v;
                    if ((v = h[s]) !== a && (v.parentElement !== a && a.parentElement !== v && isElementVisible(v))) {
                        var E = v.candidateElement;
                        if ((E = E || new CandidateElement(v, this.contentDocument)) && E.basicScore() * ReaderMinimumAdvantage > this.basicScore()) {
                            if (!g && cachedElementBoundingRect(v).bottom < cachedElementBoundingRect(this.element).top) {
                                g = !0;
                                continue
                            }
                            if (n(a.previousElementSibling, v.previousElementSibling) || n(a.nextElementSibling, v.nextElementSibling)) {
                                var N = a.querySelector(r),
                                    S = v.querySelector(r);
                                if (N && S && elementsHaveSameTagAndClassNames(N, S))
                                    return !0;
                                if (N = a.previousElementSibling, S = v.previousElementSibling, N && S && t(N) && t(S) && elementsHaveSameTagAndClassNames(N, S))
                                    return !0
                            }
                            if (elementDepth(v) === f)
                                for (; v.parentElement && a.parentElement && v.parentElement !== a.parentElement;)
                                    v = v.parentElement,
                                    a = a.parentElement;
                            for (; a.childElementCount <= 1;) {
                                if (!a.childElementCount || !v.childElementCount)
                                    return !1;
                                if (1 < v.childElementCount)
                                    return !1;
                                if (a.firstElementChild.tagName !== v.firstElementChild.tagName)
                                    return !1;
                                a = a.firstElementChild,
                                v = v.firstElementChild
                            }
                            if (v.childElementCount <= 1)
                                return !1;
                            S = v.firstElementChild;
                            var T = v.lastElementChild,
                                A = (N = a.firstElementChild, a.lastElementChild);
                            if (S.tagName !== N.tagName)
                                return !1;
                            if (T.tagName !== A.tagName)
                                return !1;
                            var x = S.className,
                                C = T.className,
                                y = N.className,
                                b = T.className,
                                R = b === y ? 2 : 1;
                            if (x.length || y.length) {
                                if (!x.length || !y.length)
                                    return !1;
                                if (x === y && a.querySelectorAll("." + y.replace(/\s+/, ".")).length <= R)
                                    return !0
                            }
                            if (C.length || b.length) {
                                if (!C.length || !b.length)
                                    return !1;
                                if (C === b && a.querySelectorAll("." + b.replace(/\s+/, ".")).length <= R)
                                    return !0
                            }
                            var D = N.clientHeight,
                                L = A.clientHeight;
                            return !(!D || !S.clientHeight) && (!(!L || !T.clientHeight) && (D === S.clientHeight || L === T.clientHeight))
                        }
                    }
                }
                for (s = 0; s < u; ++s)
                    e[s].element.candidateElement = null
            }
            return !1
        },
        shouldDisqualifyForDeepLinking: function() {
            function e(e) {
                var t = e.pathname.substring(1).split("/");
                return t[t.length - 1] || t.pop(), t
            }
            for (var t = this.element, n = this.contentDocument.location, i = e(n).length, r = [], a = t.getElementsByTagName("a"), l = a.length, o = 0; o < l; o++) {
                var s = a[o];
                if (n.host === s.host && !(e(s).length <= i || 0 !== (s.host + s.pathname).indexOf(n.host + n.pathname) || anchorLinksToAttachment(s) || (r.push(s), r.length < 5))) {
                    var c = t.offsetTop + t.offsetHeight / 5;
                    return r[0].offsetTop < c
                }
            }
            return !1
        }
    },
    ReaderArticleFinder = function(e) {
        this.contentDocument = e,
        this.didSearchForArticleNode = !1,
        this.article = null,
        this.didSearchForExtraArticleNode = !1,
        this.extraArticle = null,
        this.leadingImage = null,
        this._cachedScrollY = 0,
        this._cachedScrollX = 0,
        this._elementsWithCachedBoundingRects = [],
        this._cachedContentTextStyle = null,
        this.pageNumber = 1,
        this.prefixWithDateForNextPageURL = null,
        this._elementsEvaluatedForTextContent = [],
        this.previouslyDiscoveredPageURLStrings = []
    },
    ReaderArticleFinder.prototype = {
        isReaderModeAvailable: function() {
            return this.canRunReaderDetection() ? !!this.findArticleBySearchingWhitelist() || (this.cacheWindowScrollPosition(), this.article = this.findArticleByVisualExamination(), this.article && this.articleIsLTR(), !!this.article) : null
        },
        prepareToTransitionToReader: function() {
            this.adoptableArticle(!0),
            this.nextPageURL(),
            this.articleIsLTR()
        },
        nextPageURL: function() {
            return null
        },
        containerElementsForMultiPageContent: function() {
            for (var e, t = /(.*page.*)(\d{1,2})(.*)/i, n = [], i = this.articleNode(), r = 0; !(e = t.exec(i.getAttribute("id")));)
                if (!(i = i.parentElement) || 3 == r++)
                    return [];
            for (var a = childrenOfParentElement(i), l = a.length, o = 0; o < l; ++o) {
                var s = a[o];
                if (s !== i) {
                    var c = t.exec(s.getAttribute("id"));
                    c && c[1] === e[1] && c[3] === e[3] && (isElementVisible(s) && !isElementPositionedOffScreen(s) || n.push(s))
                }
            }
            return n
        },
        adoptableMultiPageContentElements: function() {
            return this.containerElementsForMultiPageContent().map(function(e) {
                return this.cleanArticleNode(e, e.cloneNode(!0), !1)
            }, this)
        },
        classNameIsSignificantInRouteComputation: function(e) {
            return !!e && !(e.toLowerCase() in StylisticClassNames)
        },
        shouldIgnoreInRouteComputation: function(e) {
            return "SCRIPT" === e.tagName || "LINK" === e.tagName || "STYLE" === e.tagName || "TR" === e.tagName && !e.offsetHeight
        },
        routeToArticleNode: function() {
            for (var e = [], t = this.articleNode(); t;) {
                var n = {};
                n.tagName = t.tagName;
                var i = t.getAttribute("id");
                i && (n.id = i),
                this.classNameIsSignificantInRouteComputation(t.className) && (n.className = t.className),
                n.index = 1;
                for (var r = t.previousElementSibling; r; r = r.previousElementSibling)
                    this.shouldIgnoreInRouteComputation(r) || n.index++;
                e.unshift(n),
                t = t.parentElement
            }
            return e
        },
        adjustArticleNode: function() {
            if (this.article) {
                var e;
                for (e = this.article.element; e; e = e.parentElement)
                    if (VeryPositiveClassNameRegEx.test(e.className))
                        return void (this.article.element = e);
                if ("SECTION" === (e = this.article.element).tagName && e.parentElement && "articleBody" === e.parentElement.getAttribute("itemprop"))
                    this.article.element = e.parentElement;
                else if (!(e = this.article.element).getAttribute("id") && e.className)
                    for (var t = e.tagName, n = e.className, i = e.parentElement, r = i.children, a = 0, l = r.length; a < l; ++a) {
                        var o = r[a];
                        if (o !== e && (o.tagName === t && o.className === n)) {
                            var s = CandidateElement.candidateIfElementIsViable(o, this.contentDocument, !0);
                            if (s && !(s.finalScore() < ReaderMinimumScore))
                                return void (this.article.element = i)
                        }
                    }
            }
        },
        findArticleBySearchingWhitelist: function() {
            for (var e = ListOfHostnameAndTrustedArticleNodeSelectorPairs.length, t = 0; t < e; ++t) {
                var n = ListOfHostnameAndTrustedArticleNodeSelectorPairs[t];
                if (n[0].test(this.contentDocument.location.hostname)) {
                    var i = n[1],
                        r = this.contentDocument.querySelectorAll(i);
                    if (1 === r.length)
                        return new CandidateElement(r[0], this.contentDocument)
                }
            }
            return null
        },
        fixRelativeUris: function(e) {
            if (e) {
                var t = document.location,
                    n = {
                        spec: t.href,
                        host: t.host,
                        prePath: t.protocol + "//" + t.host,
                        scheme: t.protocol.substr(0, t.protocol.indexOf(":")),
                        pathBase: t.protocol + "//" + t.host + t.pathname.substr(0, t.pathname.lastIndexOf("/") + 1)
                    },
                    i = n.scheme,
                    r = n.prePath,
                    a = n.pathBase;
                o(e.getElementsByTagName("a"), function(e) {
                    var t = e.getAttribute("href");
                    if (t)
                        if (0 === t.indexOf("javascript:")) {
                            var n = document.createTextNode(e.textContent);
                            e.parentNode.replaceChild(n, e)
                        } else
                            e.setAttribute("href", l(t))
                }),
                o(e.getElementsByTagName("img"), function(e) {
                    var t = e.getAttribute("src");
                    t && e.setAttribute("src", l(t))
                })
            }
            function l(e) {
                return /^[a-zA-Z][a-zA-Z0-9\+\-\.]*:/.test(e) ? e : "//" == e.substr(0, 2) ? i + "://" + e.substr(2) : "/" == e[0] ? r + e : 0 === e.indexOf("./") ? a + e.slice(2) : "#" == e[0] ? e : a + e
            }
            function o(e, t) {
                for (var n = 0; n < e.length; n++)
                    t(e[n])
            }
        },
        articleNode: function(e) {
            return this.didSearchForArticleNode || (this.article = this.findArticleBySearchingWhitelist(), this.article || (this.article = this.findArticleBySearchingAllElements()), this.article || (this.article = this.findArticleByVisualExamination()), !this.article && e && (this.article = this.findArticleBySearchingAllElements(!0)), this.adjustArticleNode(), this.didSearchForArticleNode = !0, this.article && this.articleIsLTR()), this.article ? this.article.element : null
        },
        extraArticleNode: function() {
            return this.didSearchForArticleNode || this.articleNode(), this.didSearchForExtraArticleNode || (this.extraArticle = this.findExtraArticle(), this.didSearchForExtraArticleNode = !0), this.extraArticle ? this.extraArticle.element : null
        },
        cacheWindowScrollPosition: function() {
            this._cachedScrollY = window.scrollY,
            this._cachedScrollX = window.scrollX
        },
        contentTextStyle: function() {
            return this._cachedContentTextStyle || (this._cachedContentTextStyle = contentTextStyleForNode(this.contentDocument, this.articleNode()), this._cachedContentTextStyle || (this._cachedContentTextStyle = getComputedStyle(this.articleNode()))), this._cachedContentTextStyle
        },
        commaCountIsLessThan: function(e, t) {
            for (var n = 0, i = e.textContent, r = -1; n < t && 0 <= (r = i.indexOf(",", r + 1));)
                n++;
            return n < t
        },
        calculateLinkDensity: function(e) {
            var t = removeWhitespace(e.textContent).length;
            if (!t)
                return 0;
            for (var n = e.getElementsByTagName("a"), i = 0, r = n.length, a = 0; a < r; ++a)
                i += removeWhitespace(n[a].textContent).length;
            return i / t
        },
        shouldPruneElement: function(e, t) {
            var n = e.tagName;
            if (!e.parentElement)
                return !1;
            if ("IFRAME" === n)
                return shouldPruneIframe(e, this.contentDocument);
            if ("OBJECT" !== n && "EMBED" !== n && "CANVAS" !== n) {
                for (var i = !1, r = e.childNodes.length, a = 0; a < r; ++a) {
                    var l = e.childNodes[a],
                        o = l.nodeType;
                    if (o === Node.ELEMENT_NODE || o === Node.TEXT_NODE && !isNodeWhitespace(l)) {
                        i = !0;
                        break
                    }
                }
                if (!i) {
                    if ("P" === n) {
                        var s = e.previousSibling,
                            c = e.nextSibling;
                        if (s && s.nodeType === Node.TEXT_NODE && !isNodeWhitespace(s) && c && c.nodeType === Node.TEXT_NODE && !isNodeWhitespace(c))
                            return !1
                    }
                    return !0
                }
                if ("P" === n)
                    return !1
            }
            if ("CANVAS" === n)
                return "CUFON" === e.parentNode.tagName;
            var h = 0;
            if (t) {
                if (VeryNegativeClassNameRegEx.test(t.className))
                    return !0;
                var u = t.className,
                    d = t.getAttribute("id");
                PositiveRegEx.test(u) && h++,
                PositiveRegEx.test(d) && h++,
                NegativeRegEx.test(u) && h--,
                NegativeRegEx.test(d) && h--
            }
            if (h < 0)
                return !0;
            if (e.querySelector(".tweet-wrapper"))
                return !1;
            if ("UL" === n || "OL" === n) {
                if (t.querySelector("iframe") && t.querySelector("script"))
                    return !0;
                var m = t.children,
                    g = m.length;
                if (!g)
                    return !0;
                var f = 0,
                    p = 0;
                for (a = 0; a < g; ++a)
                    SharingRegex.test(m[a].className) && f++,
                    NegativeRegEx.test(m[a].className) && p++;
                return MinimumRatioOfListItemsBeingRelatedToSharingToPruneEntireList <= f / g || MinimumRatioOfListItemsBeingRelatedToSharingToPruneEntireList <= p / g
            }
            if ("OBJECT" === n) {
                var v = e.querySelector("embed[src]"),
                    E = v ? anchorForURL(v.src, this.contentDocument) : null;
                if (E && HostnamesKnownToContainEmbeddableMediaRegex.test(E.hostname))
                    return !1;
                var N = e.getAttribute("data");
                return !(E = N ? anchorForURL(N, this.contentDocument) : null) || !HostnamesKnownToContainEmbeddableMediaRegex.test(E.hostname)
            }
            if (1 === e.childElementCount) {
                var S = e.firstElementChild;
                if ("A" === S.tagName)
                    return !1;
                if ("SPAN" === S.tagName && "converted-anchor" === S.className && nearestAncestorElementWithTagName(S, "TABLE"))
                    return !1
            }
            var T = e.getElementsByTagName("img"),
                A = T.length;
            if (A) {
                var x = 0;
                for (a = 0; a < A; ++a) {
                    var C = T[a].originalElement;
                    if (isElementVisible(C)) {
                        var y = cachedElementBoundingRect(C);
                        x += y.width / A * (y.height / A)
                    }
                }
                if (4e4 < x)
                    return !1
            }
            if (!this.commaCountIsLessThan(e, 10))
                return !1;
            var b = e.getElementsByTagName("p").length,
                R = e.getElementsByTagName("br").length,
                D = b + Math.floor(R / 2);
            if (D < A)
                return !0;
            if (e.getElementsByTagName("li").length > D)
                return !0;
            if (.33 < e.getElementsByTagName("input").length / D)
                return !0;
            if (e.textContent.length < 25 && 1 !== A)
                return !0;
            if (e.querySelector("embed"))
                return !0;
            var L = this.calculateLinkDensity(e);
            if (1 <= h && .5 < L)
                return !0;
            if (h < 1 && .2 < L)
                return !0;
            if ("TABLE" === n && removeWhitespace(e.innerText).length <= .5 * removeWhitespace(t.innerText).length)
                return !0;
            return !1
        },
        wordCountIsLessThan: function(e, t) {
            for (var n = 0, i = e.textContent, r = -1; 0 <= (r = i.indexOf(" ", r + 1)) && n < t;)
                n++;
            return n < t
        },
        leadingImageIsAppropriateWidth: function(e) {
            return !(!this.article || !e) && e.getBoundingClientRect().width >= this.article.element.getBoundingClientRect().width - ToleranceForLeadingImageWidthToArticleWidthForFullWidthPresentation
        },
        newDivFromNode: function(e) {
            var t = this.contentDocument.createElement("div");
            return e && (t.innerHTML = e.innerHTML), t
        },
        adoptableLeadingImage: function() {
            var e = /credit/,
                t = /caption/,
                n = /src|alt/;
            if (!this.article || !this.leadingImage || !this.leadingImageIsAppropriateWidth(this.leadingImage))
                return null;
            var i = this.leadingImage.parentNode,
                r = null,
                a = null,
                l = i.children.length;
            if ("DIV" === i.tagName && 1 < l && l < 5)
                for (var o = i.cloneNode(!0).querySelectorAll("p, div"), s = o.length, c = 0; c < s; ++c) {
                    var h = o[c];
                    e.test(h.className) ? r = h.cloneNode(!0) : t.test(h.className) && (a = h.cloneNode(!0))
                }
            var u = this.leadingImage.cloneNode(!1),
                d = u.attributes;
            for (c = 0; c < d.length; ++c) {
                var m = d[c].nodeName;
                n.test(m) || (u.removeAttribute(m), c--)
            }
            var g = this.contentDocument.createElement("div");
            if (g.className = "leading-image", g.appendChild(u), r) {
                var f = this.newDivFromNode(r);
                f.className = "credit",
                g.appendChild(f)
            }
            if (a) {
                var p = this.newDivFromNode(a);
                p.className = "caption",
                g.appendChild(p)
            }
            return g
        },
        adoptableArticle: function(e) {
            if (this._adoptableArticle)
                return this._adoptableArticle.cloneNode(!0);
            clearCachedElementBoundingRects(),
            this.cacheWindowScrollPosition();
            var t = this.articleNode(e);
            if (this._adoptableArticle = t ? t.cloneNode(!0) : null, !this._adoptableArticle)
                return this._adoptableArticle;
            if (this._articleBoundingRect = cachedElementBoundingRect(this.article.element), this._adoptableArticle = this.cleanArticleNode(t, this._adoptableArticle, !1), "P" === this._adoptableArticle.tagName) {
                var n = document.createElement("div");
                n.appendChild(this._adoptableArticle),
                this._adoptableArticle = n
            }
            var i = this.extraArticleNode();
            if (i) {
                var r = this.cleanArticleNode(i, i.cloneNode(!0), !0);
                r && (this.extraArticle.isPrepended ? this._adoptableArticle.insertBefore(r, this._adoptableArticle.firstChild) : this._adoptableArticle.appendChild(r));
                var a = cachedElementBoundingRect(this.article.element),
                    l = cachedElementBoundingRect(this.extraArticle.element),
                    o = {
                        top: Math.min(a.top, l.top),
                        right: Math.max(a.right, l.right),
                        bottom: Math.max(a.bottom, l.bottom),
                        left: Math.min(a.left, l.left)
                    };
                o.width = o.right - o.left,
                o.height = o.bottom - o.top,
                this._articleBoundingRect = o
            }
            this._articleTextContent = this._adoptableArticle.innerText;
            var s = this.adoptableLeadingImage(),
                c = (s && this._adoptableArticle.insertBefore(s, this._adoptableArticle.firstChild), this._adoptableArticle);
            return this.fixRelativeUris(c), c
        },
        elementPinToEdge: function(e) {
            if (window.scrollY < 120)
                return null;
            var t = cachedElementBoundingRect(e),
                n = e.ownerDocument.elementFromPoint((t.left + t.right) / 2, 0);
            n && n.tagName in {
                AREA: 1,
                BR: 1,
                CANVAS: 1,
                EMBED: 1,
                FRAME: 1,
                HR: 1,
                IMG: 1,
                INPUT: 1
            } && (n = n.parentElement);
            for (var i = n; i && i !== e;)
                i = i.parentNode;
            return i ? n : null
        },
        dominantContentSelectorAndDepth: function(e) {
            var i = {},
                r = {};
            walkElementSubtree(e, 2, function(e, t) {
                if (isElementVisible(e)) {
                    var n = selectorForElement(e) + " | " + t;
                    r[n] ? r[n] += 1 : (r[n] = 1, i[n] = e)
                }
            });
            var t,
                n = arrayOfKeysAndValuesOfObjectSortedByValueDescending(r);
            switch (n.length) {
            case 0:
                break;
            case 1:
                t = n[0].key;
                break;
            default:
                var a = n[0];
                a.value > n[1].value && (t = a.key)
            }
            if (!t)
                return null;
            var l = i[t];
            return {
                selector: selectorForElement(l),
                depth: depthOfElementWithinElement(l, e)
            }
        },
        functionToPreventPruningElementDueToInvisibility: function() {
            for (var e = [[/nytimes.com/, function(e, t) {
                    var n = e;
                    if (!t)
                        return !1;
                    for (; n && n !== t;) {
                        if (n.classList.contains("hidden"))
                            return !0;
                        n = n.parentElement
                    }
                    return !1
                }]], t = e.length, n = 0; n < t; ++n) {
                var i = e[n];
                if (i[0].test(this.contentDocument.location.hostname))
                    return i[1]
            }
            return function() {
                return !1
            }
        },
        cleanArticleNode: function(d, e, t) {
            function n(e) {
                c += e,
                h && (h += e),
                u && (u += e),
                m && (m += e),
                g && (g += e)
            }
            function i(e) {
                if (50 < cachedElementBoundingRect(e).height)
                    return !1;
                return !!{
                        UL: 1,
                        LI: 1,
                        NAV: 1
                    }[e.tagName] || e.parentElement === d && !e.nextElementSibling
            }
            var r = {
                    FORM: 1,
                    SCRIPT: 1,
                    STYLE: 1,
                    LINK: 1
                },
                a = {
                    DIV: 1,
                    TABLE: 1,
                    OBJECT: 1,
                    UL: 1,
                    CANVAS: 1,
                    P: 1,
                    IFRAME: 1,
                    ASIDE: 1,
                    SECTION: 1,
                    FOOTER: 1,
                    NAV: 1,
                    OL: 1
                },
                l = {
                    I: 1,
                    EM: 1
                },
                o = {
                    B: 1,
                    STRONG: 1,
                    H1: 1,
                    H2: 1,
                    H3: 1,
                    H4: 1,
                    H5: 1,
                    H6: 1
                },
                s = [],
                c = 0,
                h = 0,
                u = 0,
                m = 0,
                g = 0,
                f = d,
                p = f.ownerDocument.defaultView,
                v = e,
                E = this.articleTitle(),
                N = this._articleTitleElement,
                S = this.elementPinToEdge(d),
                T = null,
                A = isElementVisible(d),
                x = this.dominantContentSelectorAndDepth(d),
                C = function() {
                    var e = cachedElementBoundingRect(d);
                    if (0 === e.width || 0 === e.height)
                        return !0;
                    var t,
                        n = childrenWithParallelStructure(d),
                        i = n.length;
                    if (i) {
                        t = [];
                        for (var r = 0; r < i; ++r) {
                            var a = n[r];
                            if ("none" === getComputedStyle(a).float)
                                for (var l = a.children, o = l.length, s = 0; s < o; ++s)
                                    t.push(l[s]);
                            else
                                t.push(a)
                        }
                    } else
                        t = d.children;
                    var c = t.length,
                        h = 0;
                    for (r = 0; r < c; ++r) {
                        var u = t[r];
                        "none" !== getComputedStyle(u).float && (h += u.innerText.length)
                    }
                    return .8 < h / d.innerText.length
                }(),
                y = new Set;
            this.previouslyDiscoveredPageURLStrings.forEach(function(e) {
                y.add(e)
            });
            var b = this.nextPageURL();
            b && y.add(b);
            var R = null;
            this._articleTitleElement && (R = cachedElementBoundingRect(this._articleTitleElement));
            for (var D = this.functionToPreventPruningElementDueToInvisibility(); f;) {
                var L,
                    M = null,
                    I = v.tagName;
                if ((v.originalElement = f) === S && (T = v), I in r && (M = v), M || f !== N || (M = v), !M && ("H1" === I || "H2" === I))
                    if (f.offsetTop - d.offsetTop < HeaderMinimumDistanceFromArticleTop) {
                        var B = innerTextOrTextContent(f),
                            P = B.length * HeaderLevenshteinDistanceToLengthRatio;
                        levenshteinDistance(E, B) <= P && (M = v)
                    }
                if (M || this.isMediaWikiPage() && /editsection/.test(f.className) && (M = v), M || (L = getComputedStyle(f)), !M && "DIV" === I && v.parentNode) {
                    var w = f.querySelectorAll("a, blockquote, dl, div, img, ol, p, pre, table, ul");
                    if (!(h || "none" !== L.float) && !w.length) {
                        for (var F = v.parentNode, O = this.contentDocument.createElement("p"); v.firstChild;) {
                            var _ = v.firstChild;
                            O.appendChild(_)
                        }
                        F.replaceChild(O, v),
                        T === v && (T = O),
                        (v = O).originalElement = f,
                        I = v.tagName
                    }
                }
                if (!M && v.parentNode && I in a && s.push(v), !M) {
                    if (A)
                        if ("none" === L.display || "visible" !== L.visibility || computedStyleIndicatesElementIsInvisibleDueToClipping(L))
                            !!x && (c === x.depth && selectorForElement(f) === x.selector) || D(f, d) || (M = v);
                    isElementPositionedOffScreen(f) ? M = v : f === d || h || "none" === L.float || C || !(cachedElementBoundingRect(f).height >= FloatMinimumHeight || 1 < f.childElementCount) || (h = 1)
                }
                if (!M) {
                    for (var k = v.attributes, H = 0; H < k.length; ++H) {
                        var W = k[H].nodeName;
                        AttributesToRemoveRegEx.test(W) && (v.removeAttribute(W), H--)
                    }
                    if ("both" === L.clear && v.classList.add("clear"), ("UL" === I || "OL" === I) && "none" === L["list-style-type"] && "none" === L["background-image"]) {
                        var V = f.children,
                            q = V.length,
                            U = !0;
                        for (H = 0; H < q; ++H) {
                            var z = getComputedStyle(V[H]);
                            if ("none" !== z["list-style-type"] || 0 !== parseInt(z["-webkit-padding-start"])) {
                                U = !1;
                                break
                            }
                        }
                        U && v.classList.add("list-style-type-none")
                    }
                    if (m || "normal" === L.fontStyle || (I in l || (v.style.fontStyle = L.fontStyle), m = 1), g || "normal" === L.fontWeight || (I in o || (v.style.fontWeight = L.fontWeight), g = 1), h) {
                        1 === h && (cachedElementBoundingRect(f).width <= MaximumFloatWidth ? v.setAttribute("class", "auxiliary float " + L.float) : v.classList.add("auxiliary"));
                        var X = f.style.getPropertyValue("width");
                        if (X)
                            v.style.width = X;
                        else {
                            var Y = p.getMatchedCSSRules(f, "", !0);
                            if (Y)
                                for (H = Y.length - 1; 0 <= H; --H)
                                    if (X = Y[H].style.getPropertyValue("width")) {
                                        v.style.width = X;
                                        break
                                    }
                        }
                        1 !== h || X || (v.style.width = cachedElementBoundingRect(f).width + "px");
                        var J = v.parentNode === e ? 36 : 12,
                            K = v.style.width;
                        K && parseInt(K) >= screen.width - J && v.setAttribute("class", "large-element")
                    }
                    if ("TABLE" === I)
                        u = u || 1;
                    else if ("VIDEO" === I) {
                        cachedElementBoundingRect(f).width > screen.width - 36 && v.setAttribute("class", "large-element")
                    } else if ("IMG" === I) {
                        var j = !1,
                            $ = k.length;
                        for (H = 0; H < $; ++H) {
                            W = k[H].nodeName;
                            if (KnownImageLazyLoadingAttributes[W.toLowerCase()]) {
                                v.setAttribute("src", v.getAttribute(W)),
                                j = !0;
                                break
                            }
                        }
                        v.removeAttribute("border"),
                        v.removeAttribute("hspace"),
                        v.removeAttribute("vspace");
                        var G = v.getAttribute("align");
                        if (v.removeAttribute("align"), "left" !== G && "right" !== G || (v.classList.add("float"), v.classList.add(G)), !h && !j) {
                            var Q = cachedElementBoundingRect(f),
                                Z = Q.width,
                                ee = Q.height;
                            1 === Z && 1 === ee ? M = v : R && ee < MinimumHeightForImagesAboveTheArticleTitle && Q.bottom < R.top ? M = v : Z < ImageSizeTiny && ee < ImageSizeTiny && v.setAttribute("class", "reader-image-tiny")
                        }
                    } else if ("FONT" === I)
                        v.removeAttribute("size"),
                        v.removeAttribute("face"),
                        v.removeAttribute("color");
                    else if ("A" === I && v.parentNode) {
                        var te = v.getAttribute("href");
                        if (te && te.length && ("#" === te[0] || "javascript:" === te.substring(0, 11))) {
                            if (!u && !v.childElementCount && 1 === v.parentElement.childElementCount && "LI" !== v.parentElement.tagName)
                                this.contentDocument.evaluate("text()", v.parentElement, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotLength || (M = v);
                            if (!M) {
                                O = this.contentDocument.createElement("span");
                                if (1 === v.childElementCount && "IMG" === v.firstElementChild.tagName) {
                                    var ne = v.firstElementChild;
                                    ne.width > AnchorImageMinimumWidth && ne.height > AnchorImageMinimumHeight && O.setAttribute("class", "converted-image-anchor")
                                }
                                for (O.className || O.setAttribute("class", "converted-anchor"); v.firstChild;)
                                    O.appendChild(v.firstChild);
                                v.parentNode.replaceChild(O, v),
                                T === (v = O) && (T = O)
                            }
                        }
                    }
                }
                if (!M && elementIsCommentBlock(f) && (M = v), !M && "A" === I && y.has(f.href)) {
                    for (var ie, re, ae = f, le = v; (ae = ae.parentElement) && (le = le.parentElement);) {
                        if (10 < cachedElementBoundingRect(ae).top - cachedElementBoundingRect(f).top)
                            break;
                        if (ae === d)
                            break;
                        i(ae) && (ie = ae, re = le)
                    }
                    ie && (f = ie, (v = M = re).originalElement = f, I = v.tagName),
                    re = ie = le = ae = null
                }
                var oe = M ? null : f.firstElementChild;
                if (oe)
                    f = oe,
                    v = v.firstElementChild,
                    n(1);
                else {
                    for (var se; f !== d && !(se = f.nextElementSibling);)
                        f = f.parentElement,
                        v = v.parentElement,
                        n(-1);
                    if (f === d) {
                        if (M)
                            if (M.parentElement)
                                M.remove();
                            else if (t)
                                return null;
                        break
                    }
                    f = se,
                    v = v.nextElementSibling,
                    1 === h && (h = 0),
                    1 === u && (u = 0),
                    1 === m && (m = 0),
                    1 === g && (g = 0)
                }
                if (M)
                    if (M.parentElement)
                        M.remove();
                    else if (t)
                        return null
            }
            var ce = e.querySelectorAll("iframe"),
                he = ce.length;
            for (H = 0; H < he; ++H) {
                var ue = ce[H];
                if (elementLooksLikeEmbeddedTweet(ue.originalElement)) {
                    var de = this.adoptableSimpleTweetFromTwitterIframe(ue);
                    de && ue.parentElement.replaceChild(de, ue)
                }
            }
            for (H = s.length - 1; 0 <= H; --H) {
                var me = s[H];
                me.parentNode && this.shouldPruneElement(me, me.originalElement) && (T === me && ((T = me.nextElementSibling) || (T = me.parentElement)), me.remove())
            }
            var ge = e.querySelectorAll(".float");
            for (H = 0; H < ge.length; ++H) {
                var fe = !1,
                    pe = ge[H];
                if (!fe) {
                    var ve = pe.querySelectorAll("a, span.converted-image-anchor"),
                        Ee = pe.querySelectorAll("span.converted-anchor");
                    fe = pe.parentNode && Ee.length > ve.length
                }
                if (!fe) {
                    var Ne = pe.querySelectorAll("embed, object").length,
                        Se = pe.originalElement.querySelectorAll("embed, object").length;
                    !Ne && Se && (fe = !0)
                }
                if (!fe) {
                    for (var Te = pe.originalElement.getElementsByTagName("img"), Ae = Te.length, xe = 0, Ce = 0; Ce < Ae && (A && isElementVisible(Te[Ce]) && xe++, !(1 < xe)); ++Ce)
                        ;
                    if (1 === xe)
                        pe.getElementsByTagName("img").length || (fe = !0)
                }
                fe && (T === pe && ((T = pe.nextElementSibling) || (T = pe.parentElement)), pe.remove())
            }
            if (t && !removeWhitespace(e.innerText).length)
                return null;
            if (T) {
                var ye = document.createElement("div"),
                    be = T.originalElement.getBoundingClientRect(),
                    Re = 0 < be.height ? 100 * be.top / be.height : 0;
                ye.style.position = "relative",
                ye.style.top = Math.round(-Re) + "%",
                ye.setAttribute("id", "safari-reader-element-marker"),
                T.insertBefore(ye, T.firstChild)
            }
            return e
        },
        adoptableSimpleTweetFromTwitterIframe: function(e) {
            var t = e.originalElement.contentDocument.documentElement.querySelector("[data-tweet-id].expanded");
            if (!t)
                return null;
            var n = this.contentDocument.createElement("div");
            n.classList.add("tweet-wrapper");
            var i = this.contentDocument.createElement("blockquote");
            i.classList.add("simple-tweet"),
            n.appendChild(i);
            var r = t.getAttribute("data-tweet-id");
            n.setAttribute("data-reader-tweet-id", r);
            var a = t.querySelector(".dateline"),
                l = t.querySelector('[data-scribe="element:screen_name"]'),
                o = t.querySelector('[data-scribe="element:name"]'),
                s = t.querySelector(".e-entry-title");
            if (!(a && l && o && s))
                return n;
            var c = "&mdash; " + o.innerText + " (" + l.innerText + ")",
                h = this.contentDocument.createElement("p");
            h.innerHTML = s.innerHTML,
            i.appendChild(h),
            i.insertAdjacentHTML("beforeend", c);
            var u = this.contentDocument.createElement("span");
            u.innerHTML = a.innerHTML,
            i.appendChild(u);
            for (var d = i.querySelectorAll("img.twitter-emoji"), m = d.length, g = 0; g < m; ++g) {
                var f = d[g],
                    p = f.getAttribute("alt");
                if (p && 0 < p.length) {
                    var v = this.contentDocument.createElement("span");
                    v.innerText = p,
                    f.parentNode.replaceChild(v, f)
                }
            }
            return n
        },
        leadingImageNode: function() {
            if (!this.article || !this.article.element)
                return null;
            for (var e = this.article.element, t = 0; t < 3 && e.parentNode; ++t) {
                var n = (e = e.parentNode).getElementsByTagName("img")[0];
                if (n) {
                    var i = cachedElementBoundingRect(n);
                    if (250 <= i.height && i.width >= .5 * this._articleWidth) {
                        var r = this.article.element.compareDocumentPosition(n);
                        if (!(r & DocumentPositionPreceding) || r & DocumentPositionContainedBy)
                            continue;
                        if ((r = this.extraArticle ? this.extraArticle.element.compareDocumentPosition(n) : null) && (!(r & DocumentPositionPreceding) || r & DocumentPositionContainedBy))
                            continue;
                        return n
                    }
                }
            }
            return null
        },
        mainImageNode: function() {
            var e = this.leadingImageNode();
            if (e)
                return e;
            if (this.article && this.article.element)
                for (var t = this.article.element.querySelectorAll("img"), n = t.length, i = 0; i < n; ++i) {
                    var r = t[i],
                        a = r._cachedElementBoundingRect;
                    if ((a = a || r.getBoundingClientRect()).width >= MainImageMinimumWidthAndHeight && a.height >= MainImageMinimumWidthAndHeight)
                        return r
                }
            return null
        },
        articleTitle: function() {
            function e(e, t) {
                var n = e ? t.indexOf(e) : -1;
                return -1 !== n && (0 === n || n + e.length === t.length)
            }
            if (this.articleNode()) {
                if (this._articleTitle)
                    return this._articleTitle;
                var t = /header|title|headline|instapaper_title/i,
                    n = /byline|author/i,
                    i = function(e) {
                        var t = this.contentDocument.querySelector(e),
                            n = t && 2 === t.attributes.length ? t.content : null;
                        if (n) {
                            var i = this.articleTitleAndSiteNameFromTitleString(n);
                            i && (n = i.articleTitle)
                        }
                        return n
                    }.bind(this),
                    r = this.contentDocument.title,
                    a = i("head meta[property='og:title']"),
                    l = i("head meta[name='twitter:title']"),
                    o = cachedElementBoundingRect(this.articleNode());
                this.extraArticleNode() && this.extraArticle.isPrepended && (o = cachedElementBoundingRect(this.extraArticleNode()));
                var s = o.left + o.width / 2,
                    c = o.top,
                    h = c;
                if (this._articleWidth = o.width, this.leadingImage = this.leadingImageNode(), this.leadingImage)
                    h = (cachedElementBoundingRect(this.leadingImage).top + c) / 2;
                var u = "h1, h2, h3, h4, h5, .headline, .article_title, #hn-headline, .inside-head, .instapaper_title",
                    d = this.article.element.tagName;
                "DL" !== d && "DD" !== d || (u += ", dt");
                var m = this.contentDocument.querySelectorAll(u);
                m = Array.prototype.slice.call(m, 0);
                for (var g, f, p = this.contentDocument.location, v = this.article.element.getElementsByTagName("a"), E = 0; E < v.length; E++) {
                    var N = v[E];
                    if (N.offsetTop > this.articleNode().offsetTop + 20)
                        break;
                    if (f = p, (g = N).host === f.host && g.pathname === f.pathname) {
                        m.push(N);
                        break
                    }
                }
                var S,
                    T = m.map(innerTextOrTextContent),
                    A = m.length,
                    x = 0,
                    C = [],
                    y = [],
                    b = [];
                for (E = 0; E < A; ++E) {
                    var R = m[E],
                        D = stringSimilarity(r, q = T[E]);
                    if (a) {
                        var L = stringSimilarity(a, q);
                        D += L,
                        StringSimilarityToDeclareStringsNearlyIdentical < L && y.push(R)
                    }
                    if (l) {
                        var M = stringSimilarity(l, q);
                        D += M,
                        StringSimilarityToDeclareStringsNearlyIdentical < M && b.push(R)
                    }
                    D === x ? C.push(R) : x < D && (x = D, C = [R])
                }
                if (1 === y.length ? (S = y[0]).headerText = innerTextOrTextContent(S) : 1 === b.length && ((S = b[0]).headerText = innerTextOrTextContent(S)), !S)
                    for (E = 0; E < A; ++E) {
                        if (isElementVisible(R = m[E])) {
                            var I = cachedElementBoundingRect(R),
                                B = I.left + I.width / 2,
                                P = B - s,
                                w = I.top + I.height / 2 - h,
                                F = -1 !== y.indexOf(R),
                                O = -1 !== b.indexOf(R),
                                _ = R.classList.contains("instapaper_title"),
                                k = "headline" === R.getAttribute("itemprop"),
                                H = F || O || _ || k,
                                W = Math.sqrt(P * P + w * w),
                                V = H ? 500 : Math.max(500 - W, 0),
                                q = T[E],
                                U = R.getAttribute("property");
                            if (U) {
                                var z = /dc.title/i.exec(U);
                                if (z && z[0])
                                    if (1 === this.contentDocument.querySelectorAll('*[property~="' + z[0] + '"]').length) {
                                        (S = R).headerText = q;
                                        break
                                    }
                            }
                            if (!n.test(R.className)) {
                                if (!H) {
                                    if (500 < W)
                                        continue;
                                    if (B < o.left || B > o.right)
                                        continue
                                }
                                if (r && stringsAreNearlyIdentical(q, r))
                                    V *= 3;
                                else if (e(q, r))
                                    V *= 1.5;
                                else if (q.length < 8)
                                    continue;
                                var X = !1,
                                    Y = nearestAncestorElementWithTagName(R, "A");
                                if (Y = Y || R.querySelector("a")) {
                                    var J = Y.host === p.host,
                                        K = Y.pathname === p.pathname;
                                    if (J && K)
                                        V *= 1.5;
                                    else {
                                        if (J && nearestAncestorElementWithTagName(R, "LI"))
                                            continue;
                                        V *= .6,
                                        X = !0
                                    }
                                }
                                var j = fontSizeFromComputedStyle(getComputedStyle(R));
                                X || (V *= j / BaseFontSize),
                                V *= 1 + TitleCandidateDepthScoreMultiplier * elementDepth(R);
                                var $ = parseInt(this.contentTextStyle().fontSize);
                                parseInt(j) > 1.1 * $ && (V *= 1.25),
                                (t.test(R.className) || t.test(R.getAttribute("id"))) && (V *= 1.5);
                                var G = R.parentElement;
                                G && (t.test(G.className) || t.test(G.getAttribute("id"))) && (V *= 1.5),
                                -1 !== C.indexOf(R) && (V *= 1.8),
                                (!S || V > S.headerScore) && ((S = R).headerScore = V, S.headerText = q)
                            }
                        }
                    }
                if (S && 9 < domDistance(S, this.articleNode(), 10) && parseInt(getComputedStyle(S).fontSize) < 1.5 * $ && (S = null), S) {
                    var Q = (this._articleTitleElement = S).headerText.trim();
                    a && e(a, Q) ? this._articleTitle = a : r && e(r, Q) ? this._articleTitle = r : this._articleTitle = Q
                }
                return this._articleTitle || (a && e(a, r) ? this._articleTitle = a : this._articleTitle = r), this._articleTitle
            }
        },
        articleIsLTR: function() {
            if (!this._articleIsLTR) {
                var e = getComputedStyle(this.article.element);
                this._articleIsLTR = !e || "ltr" === e.direction
            }
            return this._articleIsLTR
        },
        findSuggestedCandidate: function() {
            var e,
                t,
                n = this.suggestedRouteToArticle;
            if (!n || !n.length)
                return null;
            for (t = n.length - 1; 0 <= t && (!n[t].id || !(e = this.contentDocument.getElementById(n[t].id))); --t)
                ;
            for (t++, e = e || this.contentDocument; t < n.length;) {
                for (var i = n[t], r = e.nodeType === Node.DOCUMENT_NODE ? e.documentElement : e.firstElementChild, a = 1; r && a < i.index; r = r.nextElementSibling)
                    this.shouldIgnoreInRouteComputation(r) || a++;
                if (!r)
                    return null;
                if (r.tagName !== i.tagName)
                    return null;
                if (i.className && r.className !== i.className)
                    return null;
                e = r,
                t++
            }
            return isElementVisible(e) ? new CandidateElement(e, this.contentDocument) : null
        },
        canRunReaderDetection: function() {
            var e = this.contentDocument.location.hostname,
                t = this.contentDocument.location.pathname;
            for (var n in BlacklistedHostsAllowedPathRegexMap) {
                if (new RegExp(escapeForRegExp(n)).test(e)) {
                    var i = BlacklistedHostsAllowedPathRegexMap[n];
                    return i instanceof RegExp && i.test(t)
                }
            }
            return !0
        },
        findArticleBySearchingAllElements: function(e) {
            var t = this.findSuggestedCandidate(),
                n = this.findCandidateElements();
            if (!n || !n.length)
                return t;
            if (t && t.basicScore() >= ReaderMinimumScore)
                return t;
            for (var i = this.highestScoringCandidateFromCandidates(n), r = i.element; r !== this.contentDocument; r = r.parentNode)
                if ("BLOCKQUOTE" === r.tagName) {
                    for (var a = r.parentNode, l = n.length, o = 0; o < l; ++o) {
                        var s = n[o];
                        if (s.element === a) {
                            i = s;
                            break
                        }
                    }
                    break
                }
            if (t && i.finalScore() < ReaderMinimumScore)
                return t;
            if (!e) {
                if (i.shouldDisqualifyDueToScoreDensity())
                    return null;
                if (i.shouldDisqualifyDueToHorizontalRuleDensity())
                    return null;
                if (i.shouldDisqualifyDueToHeaderDensity())
                    return null;
                if (i.shouldDisqualifyDueToSimilarElements(n))
                    return null
            }
            return i
        },
        findExtraArticle: function() {
            if (!this.article)
                return null;
            for (var e = 0, t = this.article.element; e < 3 && t; ++e, t = t.parentNode) {
                var n = this.findExtraArticleCandidateElements(t);
                if (n && n.length)
                    for (var i, r = this.sortCandidateElementsInDescendingScoreOrder(n), a = 0; a < r.length && ((i = r[a]) && i.basicScore()); a++)
                        if (!i.shouldDisqualifyDueToScoreDensity() && !i.shouldDisqualifyDueToHorizontalRuleDensity() && !(i.shouldDisqualifyDueToHeaderDensity() || cachedElementBoundingRect(i.element).height < PrependedArticleCandidateMinimumHeight && cachedElementBoundingRect(this.article.element).width !== cachedElementBoundingRect(i.element).width)) {
                            var l = contentTextStyleForNode(this.contentDocument, i.element);
                            if (l && l.fontFamily === this.contentTextStyle().fontFamily && l.fontSize === this.contentTextStyle().fontSize && i)
                                return i
                        }
            }
            return null
        },
        highestScoringCandidateFromCandidates: function(e) {
            for (var t = 0, n = null, i = e.length, r = 0; r < i; ++r) {
                var a = e[r],
                    l = a.basicScore();
                t <= l && (t = l, n = a)
            }
            return n
        },
        sortCandidateElementsInDescendingScoreOrder: function(e) {
            return e.sort(function(e, t) {
                return e.basicScore() !== t.basicScore() ? t.basicScore() - e.basicScore() : t.depth() - e.depth()
            })
        },
        findCandidateElements: function() {
            for (var e = Date.now() + 1e3, t = this.contentDocument.getElementsByTagName("*"), n = t.length, i = [], r = 0; r < n; ++r) {
                var a = t[r];
                if (!CandidateTagNamesToIgnore[a.tagName]) {
                    var l = CandidateElement.candidateIfElementIsViable(a, this.contentDocument);
                    if (l && i.push(l), Date.now() > e) {
                        i = [];
                        break
                    }
                }
            }
            var o = i.length;
            for (r = 0; r < o; ++r)
                i[r].element.candidateElement = i[r];
            for (r = 0; r < o; ++r) {
                var s = i[r];
                if ("BLOCKQUOTE" === s.element.tagName) {
                    var c = s.element.parentElement.candidateElement;
                    c && c.addTextNodesFromCandidateElement(s)
                }
            }
            for (r = 0; r < o; ++r)
                i[r].element.candidateElement = null;
            return i
        },
        findExtraArticleCandidateElements: function(e) {
            if (!this.article)
                return [];
            e = e || this.article.element;
            for (var t = "preceding-sibling::*/descendant-or-self::*", n = this.contentDocument.evaluate(t, e, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null), i = n.snapshotLength, r = [], a = 0; a < i; ++a) {
                var l = n.snapshotItem(a);
                if (!CandidateTagNamesToIgnore[l.tagName])
                    (o = CandidateElement.extraArticleCandidateIfElementIsViable(l, this.article, this.contentDocument, !0)) && r.push(o)
            }
            t = "following-sibling::*/descendant-or-self::*",
            i = (n = this.contentDocument.evaluate(t, e, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null)).snapshotLength;
            for (a = 0; a < i; ++a) {
                var o;
                l = n.snapshotItem(a);
                if (!CandidateTagNamesToIgnore[l.tagName])
                    (o = CandidateElement.extraArticleCandidateIfElementIsViable(l, this.article, this.contentDocument, !1)) && r.push(o)
            }
            return r
        },
        isGeneratedBy: function(e) {
            var t = this.contentDocument.head ? this.contentDocument.head.querySelector("meta[name=generator]") : null;
            if (!t)
                return !1;
            var n = t.content;
            return !!n && e.test(n)
        },
        isMediaWikiPage: function() {
            return this.isGeneratedBy(/^MediaWiki /)
        },
        isWordPressSite: function() {
            return this.isGeneratedBy(/^WordPress/)
        },
        nextPageURLString: function() {
            if (!this.article)
                return null;
            if (this.isMediaWikiPage())
                return null;
            var e,
                t = 0,
                n = this.article.element;
            n.parentNode && "inline" === getComputedStyle(n).display && (n = n.parentNode);
            for (var i = n, r = cachedElementBoundingRect(n).bottom + LinkMaxVerticalDistanceFromArticle; isElementNode(i) && cachedElementBoundingRect(i).bottom <= r;)
                i = i.parentNode;
            i === n || i !== this.contentDocument && !isElementNode(i) || (n = i);
            var a = this.contentDocument.evaluate(LinkCandidateXPathQuery, n, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null),
                l = a.snapshotLength;
            if (this.pageNumber <= 2 && !this.prefixWithDateForNextPageURL) {
                var o = this.contentDocument.location.pathname,
                    s = o.match(LinkDateRegex);
                s && (s = s[0], this.prefixWithDateForNextPageURL = o.substring(0, o.indexOf(s) + s.length))
            }
            for (var c = 0; c < l; ++c) {
                var h = a.snapshotItem(c),
                    u = this.scoreNextPageLinkCandidate(h);
                t < u && (e = h, t = u)
            }
            return e ? e.href : null
        },
        scoreNextPageLinkCandidate: function(e) {
            function t(e, t, n, i) {
                t.substring(0, e.length) === e && (t = t.substring(e.length), e = "");
                var r = lastInteger(t);
                if (isNaN(r))
                    return !1;
                var a = e ? lastInteger(e) : NaN;
                return (isNaN(a) || MaximumExactIntegralValue <= a) && (a = i), r === a ? lastInteger(n) === a + 1 : r === a + 1
            }
            function n(e) {
                for (var t = {}, n = e.substring(1).split("&"), i = n.length, r = 0; r < i; ++r) {
                    var a = n[r],
                        l = a.indexOf("=");
                    -1 === l ? t[a] = null : t[a.substring(0, l)] = a.substring(l + 1)
                }
                return t
            }
            var i = this.contentDocument.location;
            if (e.host !== i.host)
                return 0;
            if (e.pathname === i.pathname && e.search === i.search)
                return 0;
            if (-1 !== e.toString().indexOf("#"))
                return 0;
            if (anchorLinksToAttachment(e) || anchorLinksToTagOrCategoryPage(e))
                return 0;
            if (!isElementVisible(e))
                return 0;
            var r = cachedElementBoundingRect(e),
                a = this._articleBoundingRect,
                l = Math.max(0, Math.max(a.top - (r.top + r.height), r.top - (a.top + a.height)));
            if (r.top < a.top)
                return 0;
            if (LinkMaxVerticalDistanceFromArticle < l)
                return 0;
            if (0 < Math.max(0, Math.max(a.left - (r.left + r.width), r.left - (a.left + a.width))))
                return 0;
            var o = i.pathname,
                s = e.pathname;
            if (this.prefixWithDateForNextPageURL) {
                if (-1 === e.pathname.indexOf(this.prefixWithDateForNextPageURL))
                    return 0;
                o = o.substring(this.prefixWithDateForNextPageURL.length),
                s = s.substring(this.prefixWithDateForNextPageURL.length)
            }
            var c = s.substring(1).split("/");
            c[c.length - 1] || c.pop();
            var h = c.length,
                u = o.substring(1).split("/"),
                d = !1;
            u[u.length - 1] || (d = !0, u.pop());
            var m = u.length;
            if (h < m)
                return 0;
            for (var g = 0, f = 0, p = e.textContent, v = 0; v < h; ++v) {
                var E = c[v],
                    N = v < m ? u[v] : "";
                if (N !== E) {
                    if (v < m - 2)
                        return 0;
                    if (E.length >= N.length) {
                        for (var S = 0; E[E.length - 1 - S] === N[N.length - 1 - S];)
                            S++;
                        S && (E = E.substring(0, E.length - S), N = N.substring(0, N.length - S));
                        var T = E.indexOf(N);
                        -1 !== T && (E = E.substring(T))
                    }
                    t(N, E, p, this.pageNumber) ? f = Math.pow(LinkNextOrdinalValueBase, v - h + 1) : g++
                }
                if (1 < g)
                    return 0
            }
            var A = !1;
            if (e.search)
                for (var x in linkParameters = n(e.search), referenceParameters = n(i.search), linkParameters) {
                    var C = linkParameters[x],
                        y = x in referenceParameters ? referenceParameters[x] : null;
                    if (y !== C)
                        if (null === y && (y = ""), null === C && (C = ""), C.length < y.length)
                            g++;
                        else if (t(y, C, p, this.pageNumber)) {
                            if (LinkURLSearchParameterKeyMatchRegex.test(x)) {
                                if (o.toLowerCase() !== s.toLowerCase())
                                    return 0;
                                if (this.isWordPressSite() && d)
                                    return 0;
                                A = !0
                            }
                            if (LinkURLBadSearchParameterKeyMatchRegex.test(x)) {
                                g++;
                                continue
                            }
                            f = Math.max(f, 1 / LinkNextOrdinalValueBase)
                        } else
                            g++
                }
            if (!f)
                return 0;
            if ((LinkURLPageSlashNumberMatchRegex.test(e.href) || LinkURLSlashDigitEndMatchRegex.test(e.href)) && (A = !0), !A && h === m && stringSimilarity(o, s) < LinkMinimumURLSimilarityRatio)
                return 0;
            if (LinkURLArchiveSlashDigitEndMatchRegex.test(e))
                return 0;
            var b = LinkMatchWeight * (Math.pow(LinkMismatchValueBase, -g) + f) + LinkVerticalDistanceFromArticleWeight * l / LinkMaxVerticalDistanceFromArticle;
            A && (b += LinkURLSemanticMatchBonus),
            "LI" === e.parentNode.tagName && (b += LinkListItemBonus);
            p = e.innerText;
            return LinkNextMatchRegEx.test(p) && (b += LinkNextMatchBonus), LinkPageMatchRegEx.test(p) && (b += LinkPageMatchBonus), LinkContinueMatchRegEx.test(p) && (b += LinkContinueMatchBonus), b
        },
        elementContainsEnoughTextOfSameStyle: function(e) {
            for (var t, s, c, h, u, n = "BODY" === e.tagName, d = n ? 2 : 3, i = (t = e, s = 110, c = 0, h = [], u = {
                    P: 1,
                    STRONG: 1,
                    B: 1,
                    EM: 1,
                    I: 1,
                    SPAN: 1
                }, n && (u.CENTER = 1, u.FONT = 1), function e(t, n) {
                    if (t.nodeType !== Node.TEXT_NODE) {
                        if (t.nodeType === Node.ELEMENT_NODE && isElementVisible(t) && !(s && ++c > s || t._evaluatedForTextContent)) {
                            var i = t.tagName;
                            if ("IFRAME" !== i && "FORM" !== i) {
                                u[i] ? n-- : "UL" !== i && "OL" !== i && "TR" !== i && "TD" !== i && "TABLE" !== i && "TBODY" !== i || !function(e) {
                                    var t = e.children[0];
                                    if (t)
                                        for (var n = t.children, i = n.length, r = 0; r < i; ++r)
                                            if ("none" !== getComputedStyle(n[r]).float)
                                                return 0;
                                    return 1
                                }(t) || n--;
                                var r = n + 1;
                                if (r < d)
                                    for (var a = t.childNodes, l = a.length, o = 0; o < l; ++o)
                                        e(a[o], r)
                            }
                        }
                    } else
                        /\S/.test(t.nodeValue) && h.push(t)
                }(t, 0), h), r = 1800 / scoreMultiplierForElementTagNameAndAttributes(e) / languageScoreMultiplierForTextNodes(i), a = {}, l = i.length, o = 0; o < l; ++o) {
                var m = i[o],
                    g = m.length,
                    f = m.parentElement,
                    p = window.getComputedStyle(f),
                    v = p.fontFamily + "|" + p.fontSize,
                    E = Math.pow(g, TextNodeLengthPower);
                if (a[v]) {
                    if ((a[v] += E) > r)
                        break
                } else
                    a[v] = E
            }
            for (var v in a)
                if (a[v] > r)
                    return !0;
            return !1
        },
        pointsToUseForHitTesting: function() {
            var e = window.innerWidth,
                t = e / 4,
                n = e / 2;
            return [[n, 800], [n, 600], [t, 800], [n, 400], [n - 128, 1100], [320, 700], [3 * t, 800], [e - 320, 700], [n - 128, 1300]]
        },
        clearVisualExaminationState: function() {
            for (var e = this._elementsEvaluatedForTextContent.length, t = 0; t < e; ++t)
                delete this._elementsEvaluatedForTextContent[t]._evaluatedForTextContent;
            this._elementsEvaluatedForTextContent = []
        },
        findArticleByVisualExamination: function() {
            this.clearVisualExaminationState();
            for (var e = this.pointsToUseForHitTesting(), t = e.length, n = 0; n < t; n++)
                for (var i = elementsFromPoint(e[n][0], e[n][1]), r = 0; r < i.length; r++)
                    for (var a = i[r]; a && !a._evaluatedForTextContent; a = a.parentElement) {
                        if (VeryPositiveClassNameRegEx.test(a.className))
                            return new CandidateElement(a, this.contentDocument);
                        if (!CandidateTagNamesToIgnore[a.tagName]) {
                            var l = a.offsetWidth,
                                o = a.offsetHeight;
                            if (!l && !o) {
                                var s = cachedElementBoundingRect(a);
                                l = s.width,
                                o = s.height
                            }
                            if (!(l < CandidateMinimumWidth || o < CandidateMinimumHeight || l * o < CandidateMinimumArea)) {
                                var c = this.elementContainsEnoughTextOfSameStyle(a);
                                if (a._evaluatedForTextContent = !0, this._elementsEvaluatedForTextContent.push(a), c && !(CandidateElement.candidateElementAdjustedHeight(a) < CandidateMinimumHeight)) {
                                    var h = new CandidateElement(a, this.contentDocument);
                                    if (h.shouldDisqualifyDueToSimilarElements())
                                        return null;
                                    if (h.shouldDisqualifyDueToHorizontalRuleDensity())
                                        return null;
                                    if (h.shouldDisqualifyDueToHeaderDensity())
                                        return null;
                                    if (!h.shouldDisqualifyForDeepLinking())
                                        return h
                                }
                            }
                        }
                    }
            return null
        },
        articleTextContent: function() {
            return this._articleTextContent
        },
        pageDescription: function() {
            for (var e = this.contentDocument.querySelectorAll("head meta[name]"), t = e.length, n = 0; n < t; ++n) {
                var i = e[n];
                if ("description" === i.getAttribute("name").toLowerCase()) {
                    var r = i.getAttribute("content");
                    if (r)
                        return r.trim()
                }
            }
            return null
        },
        articleTitleAndSiteNameFromTitleString: function(e) {
            for (var t, n, i = [" - ", " – ", " — ", ": ", " | ", " » "], r = i.length, a = this.contentDocument.location.host.replace(/^(www|m)\./, ""), l = a.replace(/\.(com|info|net|org|edu)$/, "").toLowerCase(), o = 0; o < r; ++o) {
                var s = e.split(i[o]);
                if (2 === s.length) {
                    var c = s[0].trim(),
                        h = s[1].trim(),
                        u = c.toLowerCase(),
                        d = h.toLowerCase(),
                        m = Math.max(stringSimilarity(u, a), stringSimilarity(u, l)),
                        g = Math.max(stringSimilarity(d, a), stringSimilarity(d, l)),
                        f = Math.max(m, g);
                    (!n || n < f) && (n = f, t = g < m ? {
                        siteName: c,
                        articleTitle: h
                    } : {
                        siteName: h,
                        articleTitle: c
                    })
                }
            }
            return t && .6 <= n ? t : null
        },
        readingListItemInformation: function() {
            var e,
                t = this.pageDescription(),
                n = !1;
            this.adoptableArticle() ? (e = this.articleTitle(), t = t || this.articleTextContent(), n = !0) : (e = this.contentDocument.title, this.contentDocument.body && (t = t || this.contentDocument.body.innerText));
            var i = "",
                r = this.mainImageNode();
            return r && (i = r.src), {
                title: e = (e = e || userVisibleURLString(this.contentDocument.location.href)).trim().substring(0, 220),
                previewText: t = (t = t || "").trim().substring(0, 220).replace(/[\s]+/g, " "),
                mainImageURL: i,
                isReaderAvailable: n
            }
        }
    };
    var ReaderArticleFinderJS = new ReaderArticleFinder(document);
    ;
    window.__firefox__ || Object.defineProperty(window, "__firefox__", {
        enumerable: !1,
        configurable: !1,
        writable: !1,
        value: {}
    });
    var n = null,
        o = null,
        s = null,
        u = null,
        m = null,
        g = null,
        f = !1,
        y = null,
        p = null,
        h = null,
        l = null,
        b = null,
        a = null,
        w = null,
        t = /^http:\/\/127.0.0.1.*\/reader-mode\/page/,
        d = ".content p > img:only-child, .content p > a:only-child > img:only-child, .content .wp-caption img, .content figure img";
    function e() {
        if (!window.alookDisableReaderMode && -1 == location.host.indexOf("pincong.rocks"))
            if ("/" != location.pathname || 0 != location.search.length)
                if (document.location.href.match(t))
                    webkit.messageHandlers.readerModeMessageHandler.postMessage({
                        Type: "ReaderModeStateChange",
                        Value: "Active"
                    });
                else {
                    if ("http:" === document.location.protocol || "https:" === document.location.protocol) {
                        if (n && n.content)
                            return void webkit.messageHandlers.readerModeMessageHandler.postMessage({
                                Type: "ReaderModeStateChange",
                                Value: "Available"
                            });
                        var e = ReaderArticleFinderJS.isReaderModeAvailable();
                        return !e && window.__firefox__.forceReaderMode && i(), void (e || n && n.content ? webkit.messageHandlers.readerModeMessageHandler.postMessage({
                            Type: "ReaderModeStateChange",
                            Value: "Available"
                        }) : webkit.messageHandlers.readerModeMessageHandler.postMessage({
                            Type: "ReaderModeStateChange",
                            Value: "Unavailable"
                        }))
                    }
                    webkit.messageHandlers.readerModeMessageHandler.postMessage({
                        Type: "ReaderModeStateChange",
                        Value: "Unavailable"
                    })
                }
            else
                webkit.messageHandlers.readerModeMessageHandler.postMessage({
                    Type: "ReaderModeStateChange",
                    Value: "Unavailable"
                })
    }
    function i() {
        var e = n;
        return !(n = r(!1)) && window.__firefox__.forceReaderMode && (ReaderArticleFinderJS = new ReaderArticleFinder(document), n = r(!0)), n || e
    }
    function r(e) {
        var n = null,
            t = ReaderArticleFinderJS.adoptableArticle(e);
        return t && t.outerHTML && (n = {
            content: t.outerHTML,
            title: ReaderArticleFinderJS.articleTitle()
        }), n
    }
    function c(e) {
        null != o && document.body.classList.remove(o.theme),
        document.body.classList.add(e.theme);
        for (var n = document.body.getElementsByClassName("toolbar"), t = 0; t < n.length; t++)
            "black" == e.theme ? n[t].classList.add("black") : n[t].classList.remove("black");
        null != o && document.body.classList.remove("font-size" + o.fontSize),
        document.body.classList.add("font-size" + e.fontSize),
        o = e
    }
    function _() {
        function e(e) {
            var n = document.getElementsByClassName("readerpage")[0].clientWidth;
            e._originalWidth || (e._originalWidth = e.offsetWidth);
            var t = e._originalWidth,
                o = 0;
            0 < n - t && (o = (n - t) / 2);
            var l = o + "px !important",
                a = "margin-left: " + l + ";margin-right: " + l + ";";
            e.style.cssText = a
        }
        for (var n = document.querySelectorAll(d), t = n.length; 0 <= --t;) {
            var o = n[t];
            0 < o.width ? e(o) : o.onload = function() {
                e(o)
            }
        }
    }
    function k(e) {
        e.style.display = "inline-block"
    }
    function v(e) {
        if (o.theme != e) {
            var n = {};
            n.fontSize = o.fontSize,
            n.theme = e,
            c(n),
            E()
        }
    }
    function M(e) {
        var n = document.getElementById("AlookReaderFont");
        n && document.head.removeChild(n),
        e = "" == e ? "-apple-system-font" : '"' + e + '"',
        (n = document.createElement("style")).id = "AlookReaderFont",
        n.innerText = "body{font-family:" + e + ";}",
        document.head.appendChild(n)
    }
    function T(e) {
        if (!(e < 1 || 13 < e)) {
            var n = {};
            n.theme = o.theme,
            n.fontSize = e,
            c(n),
            E()
        }
    }
    function E() {
        webkit.messageHandlers.readerModeMessageHandler.postMessage({
            Type: "StyleChange",
            Value: JSON.stringify(o)
        })
    }
    function x(e, n) {
        f = !0,
        b = n,
        p.style.display = "none",
        h.style.display = e ? "none" : "block",
        S(e)
    }
    function S(e) {
        b && 0 < b.length ? (a.style.display = "block", l.style.display = "none", k(w)) : (a.style.display = "none", e && (l.style.display = "block"))
    }
    window.__firefox__.reader = {},
    window.__firefox__.reader.checkReadability = e,
    window.__firefox__.reader.readerize = i,
    window.__firefox__.reader.setNextPageErrorAndIndexPage = x,
    window.__firefox__.reader.updateFont = M,
    window.__firefox__.reader.setNextPageContentAndNewNextPageAndIndexPage = function(e, n, t, o, l) {
        f = !1,
        u = l,
        s = t,
        o && 0 < o.length && (b = o, k(w));
        var a = document.getElementById("article"),
            d = document.createElement("div");
        d.className = "readerpage",
        d.innerHTML = decodeURI(n),
        a.appendChild(d),
        m = d,
        e && 0 < e.length && (document.title = e, g = e),
        p.style.display = "none",
        h.style.display = "none",
        s && 0 != s.length || x(!0, b);
        var i = a.getElementsByClassName("readerpage");
        if (3 < i.length && 1e4 < a.scrollHeight) {
            var r = i[0].scrollHeight;
            if (document.documentElement.scrollTop > r) {
                window.prompt("_StopScroll_"),
                a.removeChild(i[0]);
                var c = document.documentElement.scrollTop - r;
                document.documentElement.scrollTop = c,
                y = c,
                setTimeout(function() {
                    document.documentElement.scrollTop = c,
                    window.prompt("_EnableScroll_"),
                    y = null
                }, 60)
            }
        }
    },
    window.__firefox__.reader.getCurrentPageAndTitle = function() {
        return {
            currentPage: u,
            currentTitle: g
        }
    };
    var H = null,
        A = null;
    function I() {
        f = !0,
        p.style.display = "block";
        var e = document.getElementById("loadingText"),
            n = e.getAttribute("loadingText"),
            t = e.getAttribute("clickText");
        H && (clearTimeout(H), H = null),
        A && (clearTimeout(A), A = null),
        e.innerText = n,
        p.onclick = null,
        H = window.setTimeout(function() {
            e.innerText = t,
            p.onclick = B,
            A = setTimeout(function() {
                e.innerText = n
            }, 1500)
        }, 3e3),
        h.style.display = "none",
        l.style.display = "none",
        a.style.display = "none",
        webkit.messageHandlers.readerModeMessageHandler.postMessage({
            Type: "LoadingNextPage",
            Value: s
        })
    }
    function B() {
        f = !1,
        p.style.display = "none",
        h.style.display = "block",
        l.style.display = "none",
        a.style.display = "none",
        webkit.messageHandlers.readerModeMessageHandler.postMessage({
            Type: "StopLoadingNextPage",
            Value: s
        })
    }
    document.location.href.match(t) ? (e(), p = document.getElementById("loading"), (h = document.getElementById("error")).onclick = function() {
        I()
    }, l = document.getElementById("end"), (a = document.getElementById("index")).onclick = function() {
        b && 0 < b.length && window.location.replace(b)
    }, (w = document.getElementById("topIndex")).onclick = function() {
        b && 0 < b.length && window.location.replace(b)
    }, function() {
        s = document.body.getAttribute("nextPage"),
        b = document.body.getAttribute("indexPage");
        var e = document.getElementsByClassName("readerpage");
        e && 0 < e.length && (m = e[0]),
        s && 0 != s.length || S(!0),
        b && 0 < b.length && k(w);
        var n = JSON.parse(document.body.getAttribute("data-readerStyle"));
        -1 != document.body.className.indexOf("dark") ? window.setTimeout(function() {
            document.body.classList.remove("dark"),
            c(n)
        }, 100) : c(n),
        _(),
        M(document.body.getAttribute("initFont")),
        document.getElementById("bg_light").onclick = function() {
            v("light")
        },
        document.getElementById("bg_green").onclick = function() {
            v("green")
        },
        document.getElementById("bg_sepia").onclick = function() {
            v("sepia")
        },
        document.getElementById("bg_sheep").onclick = function() {
            v("sheep")
        },
        document.getElementById("bg_cow").onclick = function() {
            v("cow")
        },
        document.getElementById("bg_black").onclick = function() {
            v("black")
        },
        document.getElementById("decrease").onclick = function() {
            T(o.fontSize - 1)
        },
        document.getElementById("increase").onclick = function() {
            T(o.fontSize + 1)
        },
        window.scrollTo(document.documentElement.scrollLeft, 44)
    }(), window.addEventListener("scroll", function() {
        if (s && 0 < s.length && !f) {
            if (null != y)
                return void (document.documentElement.scrollTop = y);
            var e = (document.documentElement.scrollTop || document.body.scrollTop) + window.innerHeight,
                n = document.documentElement.scrollHeight;
            m && e + .33 * m.clientHeight >= n ? I() : n <= e && I()
        }
    })) : window.setTimeout(function() {
        e()
    }, 0)
}();
