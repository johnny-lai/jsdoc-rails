$(function () {
  function scrollIntoView(element, container) {
    var containerTop = $(container).scrollTop()
      , containerBottom = containerTop + $(container).height()
      , elemTop = element.offsetTop - 24
      , elemBottom = elemTop + $(element).height() + 48
    if (elemTop < containerTop) {
        $(container).scrollTop(elemTop)
    } else if (elemBottom > containerBottom) {
        $(container).scrollTop(elemBottom - $(container).height())
    }
  }

  function loadPage (url) {
    $('body').data('url', url.match(/[^#]+/)[0])

    var path = url.match(/http:\/\/[^\/]+([^#]*)/)[1]

    // Pass to google analytics if available
    if (typeof window._gaq != 'undefined' && typeof window._gaq.push == 'function') {
        window._gaq.push(['_trackPageview', path])
    }

    var content = $('#content')
      , wrapper = $('#wrapper')
    wrapper.addClass('loading')

    $.getScript(url, function () {
      wrapper.removeClass('loading')

      // Navigate down the page to the anchor if needed
      if (url.indexOf('#') > -1) {
        window.location.href = window.location.hash
      } else {
        content.scrollTop(0)
      }
    })


    highlightTreeItem(url)
  }

  function highlightTreeItem (url) {
    $('aside li.current').removeClass('current')


    var path = url.match(/http:\/\/[^\/]+([^#]*)/)[1]
      , $li = $('aside a[href="' + path + '"]').parent()

    if (!$li.length) {
      $li = $('aside a[href="' + path.replace(/\/$/, '') + '"]').parent()
    }

    if ($li[0]) {
      $.toggleBranch($li.parents('ul:hidden').siblings('a'), function () {
          scrollIntoView($li.children('a')[0], 'aside nav')
      })
      $li.addClass('current')
      scrollIntoView($li.children('a')[0], 'aside nav')
    }
  }


  // Delay this so API tree events attach first
  setTimeout(function () {
      // Symbol URLs
      $('a[href^="' + URL_ROOT + '"]:not(.no_remote)').live('click', function (e) {
        if (this.href != location.href.match(/[^#]+/)[0]) {
            history.pushState({page: this.href}, document.title, this.href)
        }
        loadPage(this.href)
        e.preventDefault()
      })
  }, 1)


  $(window).bind('popstate', function (e) {
    if (!$('body').data('url')) {
        $('body').data('url', location.href.match(/[^#]+/)[0])
    }

    if (e.originalEvent.state && $('body').data('url') && e.originalEvent.state.page != $('body').data('url')) {
        loadPage(location.href)
    } else if (!e.originalEvent.state) {
        history.replaceState({page: $('body').data('url')}, document.title, location.href)
    }
    highlightTreeItem($('body').data('url'))
  })
})

// vim:et:st=4:fdm=marker:fdl=0:fdc=1
