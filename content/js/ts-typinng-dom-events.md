---
title: "How to declare a type for 'onClick'-like events in Typescript"
date: 2025-01-03
tags: [typescript, programming]
draft: true
---

In this article, I'll tell you how to create a type for all HTML elements' events, like
`onClick`, `onDragstart`, etc.

<!--more-->

Suppose you want to create a wrapper component around some `div` tag.
And you want to accept event handlers as component properties, like this:

```ts
const component = CreateMyComponent({
  onClick: (e) => { ...},
  onDragstart: () => {...},
})
```

For this, **we need two things**: types for html element events and template literal types.

## HtmlElementEventMap

This is the type that maps event names to their callback types.

**How I've found it?** I searched for "typescript dom event types", and the second
link redirected me to the [DOM manipulation](https://www.typescriptlang.org/docs/handbook/dom-manipulation.html) page in the typescript documentation.
There was a link to DOM type definitions, where I searched for string "click".

```ts
interface HTMLElementEventMap extends ElementEventMap, GlobalEventHandlersEventMap {
}
```

The most interesting part lies in the `GlobalEventHandlersEventMap` type
([the full source of DOM-related types](https://github.com/microsoft/TypeScript/blob/main/src/lib/dom.generated.d.ts)):

```ts
interface GlobalEventHandlersEventMap {
    "abort": UIEvent;
    "animationcancel": AnimationEvent;
    "animationend": AnimationEvent;
    "animationiteration": AnimationEvent;
    "animationstart": AnimationEvent;
    "auxclick": MouseEvent;
    "beforeinput": InputEvent;
    "beforetoggle": Event;
    "blur": FocusEvent;
    "cancel": Event;
    "canplay": Event;
    "canplaythrough": Event;
    "change": Event;
    "click": MouseEvent;
    "close": Event;
    "compositionend": CompositionEvent;
    "compositionstart": CompositionEvent;
    "compositionupdate": CompositionEvent;
    "contextlost": Event;
    "contextmenu": MouseEvent;
    "contextrestored": Event;
    "copy": ClipboardEvent;
    "cuechange": Event;
    "cut": ClipboardEvent;
    "dblclick": MouseEvent;
    "drag": DragEvent;
    "dragend": DragEvent;
    "dragenter": DragEvent;
    "dragleave": DragEvent;
    "dragover": DragEvent;
    "dragstart": DragEvent;
    "drop": DragEvent;
    "durationchange": Event;
    "emptied": Event;
    "ended": Event;
    "error": ErrorEvent;
    "focus": FocusEvent;
    "focusin": FocusEvent;
    "focusout": FocusEvent;
    "formdata": FormDataEvent;
    "gotpointercapture": PointerEvent;
    "input": Event;
    "invalid": Event;
    "keydown": KeyboardEvent;
    "keypress": KeyboardEvent;
    "keyup": KeyboardEvent;
    "load": Event;
    "loadeddata": Event;
    "loadedmetadata": Event;
    "loadstart": Event;
    "lostpointercapture": PointerEvent;
    "mousedown": MouseEvent;
    "mouseenter": MouseEvent;
    "mouseleave": MouseEvent;
    "mousemove": MouseEvent;
    "mouseout": MouseEvent;
    "mouseover": MouseEvent;
    "mouseup": MouseEvent;
    "paste": ClipboardEvent;
    "pause": Event;
    "play": Event;
    "playing": Event;
    "pointercancel": PointerEvent;
    "pointerdown": PointerEvent;
    "pointerenter": PointerEvent;
    "pointerleave": PointerEvent;
    "pointermove": PointerEvent;
    "pointerout": PointerEvent;
    "pointerover": PointerEvent;
    "pointerup": PointerEvent;
    "progress": ProgressEvent;
    "ratechange": Event;
    "reset": Event;
    "resize": UIEvent;
    "scroll": Event;
    "scrollend": Event;
    "securitypolicyviolation": SecurityPolicyViolationEvent;
    "seeked": Event;
    "seeking": Event;
    "select": Event;
    "selectionchange": Event;
    "selectstart": Event;
    "slotchange": Event;
    "stalled": Event;
    "submit": SubmitEvent;
    "suspend": Event;
    "timeupdate": Event;
    "toggle": Event;
    "touchcancel": TouchEvent;
    "touchend": TouchEvent;
    "touchmove": TouchEvent;
    "touchstart": TouchEvent;
    "transitioncancel": TransitionEvent;
    "transitionend": TransitionEvent;
    "transitionrun": TransitionEvent;
    "transitionstart": TransitionEvent;
    "volumechange": Event;
    "waiting": Event;
    "webkitanimationend": Event;
    "webkitanimationiteration": Event;
    "webkitanimationstart": Event;
    "webkittransitionend": Event;
    "wheel": WheelEvent;
}
```

## Template literal types

[Template literal types](https://www.typescriptlang.org/docs/handbook/2/template-literal-types.html) allow us to use string interpolation in type declarations.

For example, this is how we can create a `onClick` literal type:

```ts
type DomEvent = 'Click'

// type DomEventHandlerName = 'onClick'
type DomEventHandlerName = `on${DomEvent}`
```

## Implementation

All we need now is to loop over all events and create a `on`
type for each of them:

```ts
export type HTMLEventHandler = {
  [K in keyof HTMLElementEventMap as `on${Capitalize<K>}`]? : (evt: HTMLElementEventMap[K]) => void
}
```

We used [`Capitalize`](https://www.typescriptlang.org/docs/handbook/2/template-literal-types.html#capitalizestringtype) helper type, which capitalizes the first character in a string.

