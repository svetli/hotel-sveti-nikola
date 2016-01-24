//= require 'jquery'
//= require 'vendor/TweenLite.min'
//= require 'vendor/CSSPlugin.min'
//= require 'vendor/ScrollToPlugin.min'
//= require 'vendor/jquery.appear'
//= require 'vendor/owl.carousel.min'

class SN
    constructor: ->
        @window = $(window)
        @sections = []
        @triggerMenuBgOffset = 130
        @autoScrolling = false
        @headerHeight = $('#header').outerHeight()
        @bindEvents()

    bindEvents: ->
        @window.scroll @scroll
        @window.resize @resize
        @initScrollers()
        @initMap()
        @initSections()
        $('.scroll-to').on 'click', @scrollTo


    initSections: =>
        $('section, #footer').each (index, section) =>
            $section = $(section)
            @sections[$section.attr('id')] = 
                offsetTop:  $section.offset().top
                height:     $section.outerHeight()

    initScrollers: =>
        $('#owl-hotel').owlCarousel
            stopOnHover: true
            singleItem: true
            autoHeight: true

        $('#owl-restaurant').owlCarousel
            stopOnHover: true
            singleItem: true
            autoHeight: true

    initMap: =>
        mapEl = document.getElementById 'map'
        map = new google.maps.Map mapEl,
            zoom: 14
            center:
                lat: 42.2633848
                lng: 22.6824446
        marker = new google.maps.Marker
            map: map
            position:
                lat: 42.2636859
                lng: 22.6846946

        info = new google.maps.InfoWindow
            content: 'Hotel Sveti Nikola'

        marker.addListener 'click', () ->
            info.open map, marker
            

    updateNavigation: =>
        for section, sectionData of @sections
            if @sectionReachedTop(section, sectionData) || @scrollReachedBottom()
                current = if @scrollReachedBottom() then 'contacts' else section
                $('.navigation a').removeClass('active')
                $('.navigation a[href=#'+current+']').addClass('active')
        
    sectionReachedTop: (section, data) ->
        top = @scrollTop + @headerHeight
        top >= data.offsetTop && top <= data.height + data.offsetTop

    scrollReachedBottom: -> @scrollTop >= @maxScroll()

    maxScroll: -> $(document).height() - @window.height()
    
    scroll: =>
        @scrollTop = @window.scrollTop()
        $body = $('body')
        scale = Math.max(1, 1 + (@scrollTop/6000))
        opacity = Math.min(@scrollTop/600, 1)

        if  @scrollTop >= @triggerMenuBgOffset
        then $body.addClass('scrolled')
        else $body.removeClass('scrolled')

        if @scrollTop <= $('#intro').outerHeight()
            $('.parallax-bg').css('transform', 'scale('+scale+')')
        
        @updateNavigation() unless @autoScrolling

    scrollTo: (e) =>
        e.preventDefault()
        $el = $(e.currentTarget)
        target = $el.attr('href') || $el.data('scroll-to')
        targetOffsetTop = @sections[target.replace('#','')].offsetTop
        scrollY = targetOffsetTop - @headerHeight + 1
        @autoScrolling = true

        TweenLite.to window, .7,
            scrollTo:
                y: Math.min(@maxScroll(), scrollY)
                autoKill: false
            onComplete: =>
                @updateNavigation()
                @autoScrolling = false

    resize: =>
        @initSections()
$ ->
    new SN
