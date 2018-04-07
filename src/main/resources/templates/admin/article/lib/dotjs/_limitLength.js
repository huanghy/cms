view
            $ax.visibility.resetLimboAndHiddenToDefaults();
            $ax.repeater.refreshAllRepeaters();
            $ax.dynamicPanelManager.updateAllFitPanels();
            $ax.dynamicPanelManager.updatePercentPanelCache($ax('*'));
        } else {
            $ax.visibility.clearLimboAndHidden();
            _applyView(viewId);
            $ax.repeater.refreshAllRepeaters();
        }

        $ax.adaptive.triggerEvent('viewChanged', {});
        if(_loadFinished) $ax.viewChangePageAndMasters();
    };

    // gets if input is hidden due to sketch
    var BORDER_WIDTH = "borderWidth";
    var COLOR_STYLE = "colorStyle";
    var SKETCH_FACTOR = "sketchFactor";
    var _areInputsHidden = function(viewId) {
        var chain = _getAdaptiveIdChain(viewId);
        var page = $ax.pageData.page;
        var adaptiveStyles = page.adaptiveStyles;
        // keep track of props that are not sketchy, as you continue to climb up your parents;
        var notSketch = [];
        for(var i = chain.length - 1; i >= -1; i--) {
            var style = i == -1 ? page.style : adaptiveStyles[chain[i]];
            if(notSketch.indexOf(BORDER_WIDTH) == -1 && style.hasOwnProperty(BORDER_WIDTH)) {
                if(style[BORDER_WIDTH] != 0) return true;
                notSketch.push(BORDER_WIDTH);
            }
            if(notSketch.indexOf(COLOR_STYLE) == -1 && style.hasOwnProperty(COLOR_STYLE)) {
                if(style[COLOR_STYLE] != 'appliedColor') return true;
                notSketch.push(COLOR_STYLE);
            }
            if(notSketch.indexOf(SKETCH_FACTOR) == -1 && style.hasOwnProperty(SKETCH_FACTOR)) {
                if(style[SKETCH_FACTOR] != 0) return true;
                notSketch.push(SKETCH_FACTOR);
            }
        }
        return false;
    };

    var _updateInputVisibility = function(viewId, query) {
        var func = _areInputsHidden(viewId) ? 'addClass' : 'removeClass';
        query.each(function(obj, elementId) {
            var input = $jobj($ax.repeater.applySuffixToElementId(elementId, '_input'));
            if(input.length == 0) return;
            input[func]('form_sketch');
        });
    };

    // gets the inheritance chain of a particular view.
    var _getAdaptiveIdChain = $ax.adaptive.getAdaptiveIdChain = function(viewId) {
        if(!viewId) return [];
        var view = _idToView[viewId];
        var chain = [];
        var current = view;
        while(current) {
            chain[chain.length] = current.id;
            current = _idToView[current.baseViewId];
        }
        return chain.reverse();
    };

    var _getPageStyle = $ax.adaptive.getPageSt