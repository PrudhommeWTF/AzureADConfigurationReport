Function New-PSHtmlA {
    <#
        .SYNOPSIS
        Defines a hyperlink

        .DESCRIPTION
        Defines a hyperlink


        .PARAMETER download
        Specifies that the target will be downloaded when a user clicks on the hyperlink
        Accepted Values:
            filename

        .PARAMETER href
        Specifies the URL of the page the link goes to
        Accepted Values:
            URL

        .PARAMETER hreflang
        Specifies the language of the linked document
        Accepted Values:
            language_code

        .PARAMETER media
        Specifies what media/device the linked document is optimized for
        Accepted Values:
            media_query

        .PARAMETER ping
        Specifies a space-separated list of URLs to which, when the link is followed, post requests with the body ping will be sent by the browser (in the background). Typically used for tracking.
        Accepted Values:
            list_of_URLs

        .PARAMETER referrerpolicy
        Specifies which referrer to send
        Accepted Values:
            no-referrer
			no-referrer-when-downgrade
			origin
			origin-when-cross-origin
			unsafe-url

        .PARAMETER rel
        Specifies the relationship between the current document and the linked document
        Accepted Values:
            alternate
			author
			bookmark
			external
			help
			license
			next
			nofollow
			noreferrer
			noopener
			prev
			search
			tag

        .PARAMETER target
        Specifies where to open the linked document
        Accepted Values:
            _blank
			_parent
			_self
			_top
			framename

        .PARAMETER type
        Specifies the media type of the linked document
        Accepted Values:
            media_type

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $download,

        $href,

        $hreflang,

        $media,

        $ping,

        $referrerpolicy,

        $rel,

        $target,

        $type,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<A'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</A>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlB {
    <#
        .SYNOPSIS
        Defines bold text

        .DESCRIPTION
        Defines bold text


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<B'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</B>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlBody {
    <#
        .SYNOPSIS
        Defines the document's body

        .DESCRIPTION
        Defines the document's body


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Body'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Body>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlButton {
    <#
        .SYNOPSIS
        Defines a clickable button

        .DESCRIPTION
        Defines a clickable button


        .PARAMETER autofocus
        Specifies that a button should automatically get focus when the page loads
        Accepted Values:
            autofocus

        .PARAMETER disabled
        Specifies that a button should be disabled
        Accepted Values:
            disabled

        .PARAMETER form
        Specifies one or more forms the button belongs to
        Accepted Values:
            form_id

        .PARAMETER formaction
        Specifies where to send the form-data when a form is submitted. Only for type="submit"
        Accepted Values:
            URL

        .PARAMETER formenctype
        Specifies how form-data should be encoded before sending it to a server. Only for type="submit"
        Accepted Values:
            application/x-www-form-urlencoded
			multipart/form-data
			text/plain

        .PARAMETER formmethod
        Specifies how to send the form-data (which HTTP method to use). Only for type="submit"
        Accepted Values:
            get
			post

        .PARAMETER formnovalidate
        Specifies that the form-data should not be validated on submission. Only for type="submit"
        Accepted Values:
            formnovalidate

        .PARAMETER formtarget
        Specifies where to display the response after submitting the form. Only for type="submit"
        Accepted Values:
            _blank
			_self
			_parent
			_top
			framename

        .PARAMETER name
        Specifies a name for the button
        Accepted Values:
            name

        .PARAMETER type
        Specifies the type of button
        Accepted Values:
            button
			reset
			submit

        .PARAMETER value
        Specifies an initial value for the button
        Accepted Values:
            text

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $autofocus,

        $disabled,

        $form,

        $formaction,

        $formenctype,

        $formmethod,

        $formnovalidate,

        $formtarget,

        $name,

        $type,

        $value,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Button'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Button>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlCanvas {
    <#
        .SYNOPSIS
        Used to draw graphics, on the fly, via scripting (usually JavaScript)

        .DESCRIPTION
        Used to draw graphics, on the fly, via scripting (usually JavaScript)


        .PARAMETER height
        Specifies the height of the canvas
        Accepted Values:
            pixels

        .PARAMETER width
        Specifies the width of the canvas
        Accepted Values:
            pixels

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $height,

        $width,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Canvas'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Canvas>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlDiv {
    <#
        .SYNOPSIS
        Defines a section in a document

        .DESCRIPTION
        Defines a section in a document


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Div'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Div>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlH2 {
    <#
        .SYNOPSIS
        Defines a title of level 2

        .DESCRIPTION
        Defines a title of level 2


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<H2'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</H2>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlH3 {
    <#
        .SYNOPSIS
        Defines a title of level 3

        .DESCRIPTION
        Defines a title of level 3


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<H3'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</H3>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlH4 {
    <#
        .SYNOPSIS
        Defines a title of level 4

        .DESCRIPTION
        Defines a title of level 4


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<H4'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</H4>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlH5 {
    <#
        .SYNOPSIS
        Defines a title of level 5

        .DESCRIPTION
        Defines a title of level 5


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<H5'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</H5>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlHead {
    <#
        .SYNOPSIS
        Defines information about the document

        .DESCRIPTION
        Defines information about the document


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Head'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Head>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlHeader {
    <#
        .SYNOPSIS
        Defines a header for a document or section

        .DESCRIPTION
        Defines a header for a document or section


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Header'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Header>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlHtml {
    <#
        .SYNOPSIS
        Defines the root of an HTML document

        .DESCRIPTION
        Defines the root of an HTML document


        .PARAMETER xmlns
        Specifies the XML namespace attribute (If you need your content to conform to XHTML)
        Accepted Values:
            http://www.w3.org/1999/xhtml

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $xmlns,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Html'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Html>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlImg {
    <#
        .SYNOPSIS
        Defines an image

        .DESCRIPTION
        Defines an image


        .PARAMETER alt
        Specifies an alternate text for an image
        Accepted Values:
            text

        .PARAMETER crossorigin
        Allow images from third-party sites that allow cross-origin access to be used with canvas
        Accepted Values:
            anonymous
			use-credentials

        .PARAMETER height
        Specifies the height of an image
        Accepted Values:
            pixels

        .PARAMETER ismap
        Specifies an image as a server-side image-map
        Accepted Values:
            ismap

        .PARAMETER longdesc
        Specifies a URL to a detailed description of an image
        Accepted Values:
            URL

        .PARAMETER sizes
        Specifies image sizes for different page layouts
        Accepted Values:


        .PARAMETER src
        Specifies the URL of an image
        Accepted Values:
            URL

        .PARAMETER srcset
        Specifies the URL of the image to use in different situations
        Accepted Values:
            URL

        .PARAMETER usemap
        Specifies an image as a client-side image-map
        Accepted Values:
            #mapname

        .PARAMETER width
        Specifies the width of an image
        Accepted Values:
            pixels

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $alt,

        $crossorigin,

        $height,

        $ismap,

        $longdesc,

        $sizes,

        $src,

        $srcset,

        $usemap,

        $width,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Img'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Img>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlInput {
    <#
        .SYNOPSIS
        Defines an input control

        .DESCRIPTION
        Defines an input control


        .PARAMETER accept
        Specifies a filter for what file types the user can pick from the file input dialog box (only for type="file")
        Accepted Values:
            file_extension
			audio/*
			video/*
			image/*
			media_type

        .PARAMETER alt
        Specifies an alternate text for images (only for type="image")
        Accepted Values:
            text

        .PARAMETER autocomplete
        Specifies whether an <input> element should have autocomplete enabled
        Accepted Values:
            on
			off

        .PARAMETER autofocus
        Specifies that an <input> element should automatically get focus when the page loads
        Accepted Values:
            autofocus

        .PARAMETER checked
        Specifies that an <input> element should be pre-selected when the page loads (for type="checkbox" or type="radio")
        Accepted Values:
            checked

        .PARAMETER dirname
        Specifies that the text direction will be submitted
        Accepted Values:
            inputname.dir

        .PARAMETER disabled
        Specifies that an <input> element should be disabled
        Accepted Values:
            disabled

        .PARAMETER form
        Specifies the form the <input> element belongs to
        Accepted Values:
            form_id

        .PARAMETER formaction
        Specifies the URL of the file that will process the input control when the form is submitted (for type="submit" and type="image")
        Accepted Values:
            URL

        .PARAMETER formenctype
        Specifies how the form-data should be encoded when submitting it to the server (for type="submit" and type="image")
        Accepted Values:
            application/x-www-form-urlencoded
			multipart/form-data
			text/plain

        .PARAMETER formmethod
        Defines the HTTP method for sending data to the action URL (for type="submit" and type="image")
        Accepted Values:
            get
			post

        .PARAMETER formnovalidate
        Defines that form elements should not be validated when submitted
        Accepted Values:
            formnovalidate

        .PARAMETER formtarget
        Specifies where to display the response that is received after submitting the form (for type="submit" and type="image")
        Accepted Values:
            _blank
			_self
			_parent
			_top
			framename

        .PARAMETER height
        Specifies the height of an <input> element (only for type="image")
        Accepted Values:
            pixels

        .PARAMETER list
        Refers to a <datalist> element that contains pre-defined options for an <input> element
        Accepted Values:
            datalist_id

        .PARAMETER max
        Specifies the maximum value for an <input> element
        Accepted Values:
            number
			date

        .PARAMETER maxlength
        Specifies the maximum number of characters allowed in an <input> element
        Accepted Values:
            number

        .PARAMETER min
        Specifies a minimum value for an <input> element
        Accepted Values:
            number
			date

        .PARAMETER multiple
        Specifies that a user can enter more than one value in an <input> element
        Accepted Values:
            multiple

        .PARAMETER name
        Specifies the name of an <input> element
        Accepted Values:
            text

        .PARAMETER pattern
        Specifies a regular expression that an <input> element's value is checked against
        Accepted Values:
            regexp

        .PARAMETER placeholder
        Specifies a short hint that describes the expected value of an <input> element
        Accepted Values:
            text

        .PARAMETER readonly
        Specifies that an input field is read-only
        Accepted Values:
            readonly

        .PARAMETER required
        Specifies that an input field must be filled out before submitting the form
        Accepted Values:
            required

        .PARAMETER size
        Specifies the width, in characters, of an <input> element
        Accepted Values:
            number

        .PARAMETER src
        Specifies the URL of the image to use as a submit button (only for type="image")
        Accepted Values:
            URL

        .PARAMETER step
        Specifies the interval between legal numbers in an input field
        Accepted Values:
            number
			any

        .PARAMETER type
        Specifies the type <input> element to display
        Accepted Values:
            button
			checkbox
			color
			date
			datetime-local
			email
			file
			hidden
			image
			month
			number
			password
			radio
			range
			reset
			search
			submit
			tel
			text
			time
			url
			week

        .PARAMETER value
        Specifies the value of an <input> element

        Accepted Values:
            text

        .PARAMETER width
        Specifies the width of an <input> element (only for type="image")
        Accepted Values:
            pixels

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accept,

        $alt,

        $autocomplete,

        $autofocus,

        $checked,

        $dirname,

        $disabled,

        $form,

        $formaction,

        $formenctype,

        $formmethod,

        $formnovalidate,

        $formtarget,

        $height,

        $list,

        $max,

        $maxlength,

        $min,

        $multiple,

        $name,

        $pattern,

        $placeholder,

        $readonly,

        $required,

        $size,

        $src,

        $step,

        $type,

        $value,

        $width,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Input'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }
    $Output += ">"

    Write-Output -InputObject $Output
}
Function New-PSHtmlLabel {
    <#
        .SYNOPSIS
        Defines a label for an <input> element

        .DESCRIPTION
        Defines a label for an <input> element


        .PARAMETER for
        Specifies which form element a label is bound to
        Accepted Values:
            element_id

        .PARAMETER form
        Specifies one or more forms the label belongs to
        Accepted Values:
            form_id

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $for,

        $form,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Label'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Label>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlLi {
    <#
        .SYNOPSIS
        Defines a list item

        .DESCRIPTION
        Defines a list item


        .PARAMETER value
        Specifies the value of a list item. The following list items will increment from that number (only for <ol> lists)
        Accepted Values:
            number

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $value,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Li'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Li>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlLink {
    <#
        .SYNOPSIS
        Defines the relationship between a document and an external resource (most used to link to style sheets)

        .DESCRIPTION
        Defines the relationship between a document and an external resource (most used to link to style sheets)


        .PARAMETER crossorigin
        Specifies how the element handles cross-origin requests
        Accepted Values:
            anonymous
			use-credentials

        .PARAMETER href
        Specifies the location of the linked document
        Accepted Values:
            URL

        .PARAMETER hreflang
        Specifies the language of the text in the linked document
        Accepted Values:
            language_code

        .PARAMETER media
        Specifies on what device the linked document will be displayed
        Accepted Values:
            media_query

        .PARAMETER rel
        Required. Specifies the relationship between the current document and the linked document
        Accepted Values:
            alternate
			author
			dns-prefetch
			help
			icon
			license
			next
			pingback
			preconnect
			prefetch
			preload
			prerender
			prev
			search
			stylesheet

        .PARAMETER sizes
        Specifies the size of the linked resource. Only for rel="icon"
        Accepted Values:
            HeightxWidth
			any

        .PARAMETER type
        Specifies the media type of the linked document
        Accepted Values:
            media_type

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $crossorigin,

        $href,

        $hreflang,

        $media,

        $rel,

        $sizes,

        $type,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Link'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Link>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlMain {
    <#
        .SYNOPSIS
        Specifies the main content of a document

        .DESCRIPTION
        Specifies the main content of a document


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Main'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Main>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlMeta {
    <#
        .SYNOPSIS
        Defines metadata about an HTML document

        .DESCRIPTION
        Defines metadata about an HTML document


        .PARAMETER charset
        Specifies the character encoding for the HTML document
        Accepted Values:
            character_set

        .PARAMETER http_equiv
        Provides an HTTP header for the information/value of the content attribute
        Accepted Values:
            content-type
			default-style
			refresh

        .PARAMETER name
        Specifies a name for the metadata
        Accepted Values:
            application-name
			author
			description
			generator
			keywords
			viewport

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $charset,

        $http_equiv,

        $name,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Meta'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Meta>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlNav {
    <#
        .SYNOPSIS
        Defines navigation links

        .DESCRIPTION
        Defines navigation links


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Nav'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Nav>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlOl {
    <#
        .SYNOPSIS
        Defines an ordered list

        .DESCRIPTION
        Defines an ordered list


        .PARAMETER reversed
        Specifies that the list order should be descending (9,8,7...)
        Accepted Values:
            reversed

        .PARAMETER start
        Specifies the start value of an ordered list
        Accepted Values:
            number

        .PARAMETER type
        Specifies the kind of marker to use in the list
        Accepted Values:
            1
			A
			a
			I
			i

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $reversed,

        $start,

        $type,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Ol'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Ol>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlP {
    <#
        .SYNOPSIS
        Defines a paragraph

        .DESCRIPTION
        Defines a paragraph


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<P'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</P>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlScript {
    <#
        .SYNOPSIS
        Defines a client-side script

        .DESCRIPTION
        Defines a client-side script


        .PARAMETER async
        Specifies that the script is executed asynchronously (only for external scripts)
        Accepted Values:
            async

        .PARAMETER charset
        Specifies the character encoding used in an external script file
        Accepted Values:
            charset

        .PARAMETER defer
        Specifies that the script is executed when the page has finished parsing (only for external scripts)
        Accepted Values:
            defer

        .PARAMETER src
        Specifies the URL of an external script file
        Accepted Values:
            URL

        .PARAMETER type
        Specifies the media type of the script
        Accepted Values:
            media_type

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $async,

        $charset,

        $defer,

        $src,

        $type,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Script'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Script>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlSpan {
    <#
        .SYNOPSIS
        Defines a section in a document

        .DESCRIPTION
        Defines a section in a document


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Span'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Span>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlStyle {
    <#
        .SYNOPSIS
        Defines style information for a document

        .DESCRIPTION
        Defines style information for a document


        .PARAMETER media
        Specifies what media/device the media resource is optimized for
        Accepted Values:
            media_query

        .PARAMETER type
        Specifies the media type of the <style> tag
        Accepted Values:
            text/css

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $media,

        $type,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Style'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Style>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlSvg {
    <#
        .SYNOPSIS
        Defines a container for SVG graphics

        .DESCRIPTION
        Defines a container for SVG graphics



        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Svg'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Svg>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlTable {
    <#
        .SYNOPSIS
        Defines a table

        .DESCRIPTION
        Defines a table


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Table'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Table>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlTbody {
    <#
        .SYNOPSIS
        Groups the body content in a table

        .DESCRIPTION
        Groups the body content in a table


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Tbody'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Tbody>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlTd {
    <#
        .SYNOPSIS
        Defines a cell in a table

        .DESCRIPTION
        Defines a cell in a table


        .PARAMETER colspan
        Specifies the number of columns a cell should span
        Accepted Values:
            number

        .PARAMETER headers
        Specifies one or more header cells a cell is related to
        Accepted Values:
            header_id

        .PARAMETER rowspan
        Sets the number of rows a cell should span
        Accepted Values:
            number

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $colspan,

        $headers,

        $rowspan,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Td'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Td>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlTh {
    <#
        .SYNOPSIS
        Defines a header cell in a table

        .DESCRIPTION
        Defines a header cell in a table


        .PARAMETER abbr
        Specifies an abbreviated version of the content in a header cell
        Accepted Values:
            text

        .PARAMETER colspan
        Specifies the number of columns a header cell should span
        Accepted Values:
            number

        .PARAMETER headers
        Specifies one or more header cells a cell is related to
        Accepted Values:
            header_id

        .PARAMETER rowspan
        Specifies the number of rows a header cell should span
        Accepted Values:
            number

        .PARAMETER scope
        Specifies whether a header cell is a header for a column, row, or group of columns or rows
        Accepted Values:
            col
			colgroup
			row
			rowgroup

        .PARAMETER sorted
        Defines the sort direction of a column
        Accepted Values:
            reversed
			number
			reversed number
			number reversed

        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $abbr,

        $colspan,

        $headers,

        $rowspan,

        $scope,

        $sorted,

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Th'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Th>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlThead {
    <#
        .SYNOPSIS
        Groups the header content in a table

        .DESCRIPTION
        Groups the header content in a table


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Thead'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Thead>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlTitle {
    <#
        .SYNOPSIS
        Defines a title for the document

        .DESCRIPTION
        Defines a title for the document


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Title'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Title>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlTr {
    <#
        .SYNOPSIS
        Defines a row in a table

        .DESCRIPTION
        Defines a row in a table


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Tr'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Tr>"

    Write-Output -InputObject $Output
}
Function New-PSHtmlUl {
    <#
        .SYNOPSIS
        Defines an unordered list

        .DESCRIPTION
        Defines an unordered list


        .PARAMETER accesskey
        Specifies a shortcut key to activate/focus an element

        .PARAMETER class
        Specifies one or more classnames for an element (refers to a class in a style sheet)

        .PARAMETER contenteditable
        Specifies whether the content of an element is editable or not

        .PARAMETER dir
        Specifies the text direction for the content in an element

        .PARAMETER draggable
        Specifies whether an element is draggable or not

        .PARAMETER dropzone
        Specifies whether the dragged data is copied, moved, or linked, when dropped

        .PARAMETER hidden
        Specifies that an element is not yet, or is no longer, relevant

        .PARAMETER id
        Specifies a unique id for an element

        .PARAMETER lang
        Specifies the language of the element's content

        .PARAMETER spellcheck
        Specifies whether the element is to have its spelling and grammar checked or not

        .PARAMETER style
        Specifies an inline CSS style for an element

        .PARAMETER tabindex
        Specifies the tabbing order of an element

        .PARAMETER title
        Specifies extra information about an element

        .PARAMETER translate
        Specifies whether the content of an element should be translated or not

        .PARAMETER onafterprint
        Script to be run after the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeprint
        Script to be run before the document is printed
        Accepted Values:
            script

        .PARAMETER onbeforeunload
        Script to be run when the document is about to be unloaded
        Accepted Values:
            script

        .PARAMETER onerror
        Script to be run when an error occurs
        Accepted Values:
            script

        .PARAMETER onhashchange
        Script to be run when there has been changes to the anchor part of the a URL
        Accepted Values:
            script

        .PARAMETER onload
        Fires after the page is finished loading
        Accepted Values:
            script

        .PARAMETER onmessage
        Script to be run when the message is triggered
        Accepted Values:
            script

        .PARAMETER onoffline
        Script to be run when the browser starts to work offline
        Accepted Values:
            script

        .PARAMETER ononline
        Script to be run when the browser starts to work online
        Accepted Values:
            script

        .PARAMETER onpagehide
        Script to be run when a user navigates away from a page
        Accepted Values:
            script

        .PARAMETER onpageshow
        Script to be run when a user navigates to a page
        Accepted Values:
            script

        .PARAMETER onpopstate
        Script to be run when the window's history changes
        Accepted Values:
            script

        .PARAMETER onresize
        Fires when the browser window is resized
        Accepted Values:
            script

        .PARAMETER onstorage
        Script to be run when a Web Storage area is updated
        Accepted Values:
            script

        .PARAMETER onunload
        Fires once a page has unloaded (or the browser window has been closed)
        Accepted Values:
            script

        .PARAMETER onblur
        Fires the moment that the element loses focus
        Accepted Values:
            script

        .PARAMETER onchange
        Fires the moment when the value of the element is changed
        Accepted Values:
            script

        .PARAMETER oncontextmenu
        Script to be run when a context menu is triggered
        Accepted Values:
            script

        .PARAMETER onfocus
        Fires the moment when the element gets focus
        Accepted Values:
            script

        .PARAMETER oninput
        Script to be run when an element gets user input
        Accepted Values:
            script

        .PARAMETER oninvalid
        Script to be run when an element is invalid
        Accepted Values:
            script

        .PARAMETER onreset
        Fires when the Reset button in a form is clicked
        Accepted Values:
            script

        .PARAMETER onsearch
        Fires when the user writes something in a search field (for <input="search">)
        Accepted Values:
            script

        .PARAMETER onselect
        Fires after some text has been selected in an element
        Accepted Values:
            script

        .PARAMETER onsubmit
        Fires when a form is submitted
        Accepted Values:
            script

        .PARAMETER onkeydown
        Fires when a user is pressing a key
        Accepted Values:
            script

        .PARAMETER onkeypress
        Fires when a user presses a key
        Accepted Values:
            script

        .PARAMETER onkeyup
        Fires when a user releases a key
        Accepted Values:
            script

        .PARAMETER onclick
        Fires on a mouse click on the element
        Accepted Values:
            script

        .PARAMETER ondblclick
        Fires on a mouse double-click on the element
        Accepted Values:
            script

        .PARAMETER onmousedown
        Fires when a mouse button is pressed down on an element
        Accepted Values:
            script

        .PARAMETER onmousemove
        Fires when the mouse pointer is moving while it is over an element
        Accepted Values:
            script

        .PARAMETER onmouseout
        Fires when the mouse pointer moves out of an element
        Accepted Values:
            script

        .PARAMETER onmouseover
        Fires when the mouse pointer moves over an element
        Accepted Values:
            script

        .PARAMETER onmouseup
        Fires when a mouse button is released over an element
        Accepted Values:
            script

        .PARAMETER onmousewheel
        Deprecated. Use the onwheel attribute instead
        Accepted Values:
            script

        .PARAMETER onwheel
        Fires when the mouse wheel rolls up or down over an element
        Accepted Values:
            script

        .PARAMETER ondrag
        Script to be run when an element is dragged
        Accepted Values:
            script

        .PARAMETER ondragend
        Script to be run at the end of a drag operation
        Accepted Values:
            script

        .PARAMETER ondragenter
        Script to be run when an element has been dragged to a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragleave
        Script to be run when an element leaves a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragover
        Script to be run when an element is being dragged over a valid drop target
        Accepted Values:
            script

        .PARAMETER ondragstart
        Script to be run at the start of a drag operation
        Accepted Values:
            script

        .PARAMETER ondrop
        Script to be run when dragged element is being dropped
        Accepted Values:
            script

        .PARAMETER onscroll
        Script to be run when an element's scrollbar is being scrolled
        Accepted Values:
            script

        .PARAMETER oncopy
        Fires when the user copies the content of an element
        Accepted Values:
            script

        .PARAMETER oncut
        Fires when the user cuts the content of an element
        Accepted Values:
            script

        .PARAMETER onpaste
        Fires when the user pastes some content in an element
        Accepted Values:
            script

        .PARAMETER onabort
        Script to be run on abort
        Accepted Values:
            script

        .PARAMETER oncanplay
        Script to be run when a file is ready to start playing (when it has buffered enough to begin)
        Accepted Values:
            script

        .PARAMETER oncanplaythrough
        Script to be run when a file can be played all the way to the end without pausing for buffering
        Accepted Values:
            script

        .PARAMETER oncuechange
        Script to be run when the cue changes in a <track> element
        Accepted Values:
            script

        .PARAMETER ondurationchange
        Script to be run when the length of the media changes
        Accepted Values:
            script

        .PARAMETER onemptied
        Script to be run when something bad happens and the file is suddenly unavailable (like unexpectedly disconnects)
        Accepted Values:
            script

        .PARAMETER onended
        Script to be run when the media has reach the end (a useful event for messages like "thanks for listening")
        Accepted Values:
            script

        .PARAMETER onloadeddata
        Script to be run when media data is loaded
        Accepted Values:
            script

        .PARAMETER onloadedmetadata
        Script to be run when meta data (like dimensions and duration) are loaded
        Accepted Values:
            script

        .PARAMETER onloadstart
        Script to be run just as the file begins to load before anything is actually loaded
        Accepted Values:
            script

        .PARAMETER onpause
        Script to be run when the media is paused either by the user or programmatically
        Accepted Values:
            script

        .PARAMETER onplay
        Script to be run when the media is ready to start playing
        Accepted Values:
            script

        .PARAMETER onplaying
        Script to be run when the media actually has started playing
        Accepted Values:
            script

        .PARAMETER onprogress
        Script to be run when the browser is in the process of getting the media data
        Accepted Values:
            script

        .PARAMETER onratechange
        Script to be run each time the playback rate changes (like when a user switches to a slow motion or fast forward mode)
        Accepted Values:
            script

        .PARAMETER onseeked
        Script to be run when the seeking attribute is set to false indicating that seeking has ended
        Accepted Values:
            script

        .PARAMETER onseeking
        Script to be run when the seeking attribute is set to true indicating that seeking is active
        Accepted Values:
            script

        .PARAMETER onstalled
        Script to be run when the browser is unable to fetch the media data for whatever reason
        Accepted Values:
            script

        .PARAMETER onsuspend
        Script to be run when fetching the media data is stopped before it is completely loaded for whatever reason
        Accepted Values:
            script

        .PARAMETER ontimeupdate
        Script to be run when the playing position has changed (like when the user fast forwards to a different point in the media)
        Accepted Values:
            script

        .PARAMETER onvolumechange
        Script to be run each time the volume is changed which (includes setting the volume to "mute")
        Accepted Values:
            script

        .PARAMETER onwaiting
        Script to be run when the media has paused but is expected to resume (like when the media pauses to buffer more data)
        Accepted Values:
            script

        .PARAMETER ontoggle
        Fires when the user opens or closes the <details> element
        Accepted Values:
            script


        .PARAMETER OtherAttributes
        Allows you to provide any other attributes to the HTML tag
    #>
    [CmdletBinding()]
    Param(

        $accesskey,

        $class,

        $contenteditable,

        $dir,

        $draggable,

        $dropzone,

        $hidden,

        $id,

        $lang,

        $spellcheck,

        $style,

        $tabindex,

        $title,

        $translate,

        $onafterprint,

        $onbeforeprint,

        $onbeforeunload,

        $onerror,

        $onhashchange,

        $onload,

        $onmessage,

        $onoffline,

        $ononline,

        $onpagehide,

        $onpageshow,

        $onpopstate,

        $onresize,

        $onstorage,

        $onunload,

        $onblur,

        $onchange,

        $oncontextmenu,

        $onfocus,

        $oninput,

        $oninvalid,

        $onreset,

        $onsearch,

        $onselect,

        $onsubmit,

        $onkeydown,

        $onkeypress,

        $onkeyup,

        $onclick,

        $ondblclick,

        $onmousedown,

        $onmousemove,

        $onmouseout,

        $onmouseover,

        $onmouseup,

        $onmousewheel,

        $onwheel,

        $ondrag,

        $ondragend,

        $ondragenter,

        $ondragleave,

        $ondragover,

        $ondragstart,

        $ondrop,

        $onscroll,

        $oncopy,

        $oncut,

        $onpaste,

        $onabort,

        $oncanplay,

        $oncanplaythrough,

        $oncuechange,

        $ondurationchange,

        $onemptied,

        $onended,

        $onloadeddata,

        $onloadedmetadata,

        $onloadstart,

        $onpause,

        $onplay,

        $onplaying,

        $onprogress,

        $onratechange,

        $onseeked,

        $onseeking,

        $onstalled,

        $onsuspend,

        $ontimeupdate,

        $onvolumechange,

        $onwaiting,

        $ontoggle,

        $Content,

        [Collections.Hashtable]$OtherAttributes
    )

    $Output = '<Ul'

    foreach ($key in ($MyInvocation.BoundParameters.keys | Where-Object -FilterScript {$_ -ne 'content'})) {
        if ($key -eq 'OtherAttributes') {
            $OtherAttributes = (Get-Variable -Name $key).Value
            $OtherAttributes.Keys | ForEach-Object -Process {
                $Output += " $($_)=`"$($OtherAttributes[$_])`""
            }
        } else {
            $value = (Get-Variable -Name $key).Value
            if ($key -match '_') {$key -replace '_','-'}
            $Output += " $key=`"$value`""
        }
    }

    if ($Content -is [Management.Automation.ScriptBlock]) {
        $Out = $Content.Invoke()
    } else {
        $Out = $Content
    }

    $Output += ">$Out</Ul>"

    Write-Output -InputObject $Output
}