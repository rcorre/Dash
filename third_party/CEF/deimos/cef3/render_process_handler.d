module deimos.cef3.render_process_handler;

// Copyright (c) 2012 Marshall A. Greenblatt. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//    * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//    * Neither the name of Google Inc. nor the name Chromium Embedded
// Framework nor the names of its contributors may be used to endorse
// or promote products derived from this software without specific prior
// written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// ---------------------------------------------------------------------------
//
// This file was generated by the CEF translator tool and should not edited
// by hand. See the translator.README.txt file in the tools directory for
// more information.
//

extern(C) {

import deimos.cef3.base;
import deimos.cef3.browser;
import deimos.cef3.dom;
import deimos.cef3.frame;
import deimos.cef3.load_handler;
import deimos.cef3.process_message;
import deimos.cef3.v8;
import deimos.cef3.values;
import deimos.cef3.request;


///
// Structure used to implement render process callbacks. The functions of this
// structure will be called on the render process main thread (TID_RENDERER)
// unless otherwise indicated.
///
struct cef_render_process_handler_t {
    ///
    // Base structure.
    ///
    cef_base_t base;

    ///
    // Called after the render process main thread has been created. |extra_info|
    // is a read-only value originating from
    // cef_browser_process_handler_t::on_render_process_thread_created(). Do not
    // keep a reference to |extra_info| outside of this function.
    ///
    extern(System) void function(   cef_render_process_handler_t* self,
                                    cef_list_value_t* extra_info) on_render_thread_created;

    ///
    // Called after WebKit has been initialized.
    ///
    extern(System) void function(   cef_render_process_handler_t* self) on_web_kit_initialized;

    ///
    // Called after a browser has been created. When browsing cross-origin a new
    // browser will be created before the old browser with the same identifier is
    // destroyed.
    ///
    extern(System) void function(   cef_render_process_handler_t* self,
                                    cef_browser_t* browser) on_browser_created;

    ///
    // Called before a browser is destroyed.
    ///
    extern(System) void function(   cef_render_process_handler_t* self,
                                    cef_browser_t* browser) on_browser_destroyed;

    ///
    // Return the handler for browser load status events.
    ///
    extern(System) cef_load_handler_t* function(cef_render_process_handler_t *self) get_load_handler;

    ///
    // Called before browser navigation. Return true (1) to cancel the navigation
    // or false (0) to allow the navigation to proceed. The |request| object
    // cannot be modified in this callback.
    ///
    extern(System) int function(    cef_render_process_handler_t *self, 
                                    cef_browser_t *browser, 
                                    cef_frame_t *frame, 
                                    cef_request_t *request, 
                                    cef_navigation_type_t navigation_type, 
                                    int is_redirect) on_before_navigation;


    ///
    // Called immediately after the V8 context for a frame has been created. To
    // retrieve the JavaScript 'window' object use the
    // cef_v8context_t::get_global() function. V8 handles can only be accessed
    // from the thread on which they are created. A task runner for posting tasks
    // on the associated thread can be retrieved via the
    // cef_v8context_t::get_task_runner() function.
    ///
    extern(System) void function(   cef_render_process_handler_t* self,
                                    cef_browser_t* browser,
                                    cef_frame_t* frame,
                                    cef_v8context_t* context) on_context_created;

    ///
    // Called immediately before the V8 context for a frame is released. No
    // references to the context should be kept after this function is called.
    ///
    extern(System) void function(   cef_render_process_handler_t* self,
                                    cef_browser_t* browser,
                                    cef_frame_t* frame,
                                    cef_v8context_t* context) on_context_released;

    ///
    // Called for global uncaught exceptions in a frame. Execution of this
    // callback is disabled by default. To enable set
    // CefSettings.uncaught_exception_stack_size > 0.
    ///
    extern(System) void function(   cef_render_process_handler_t *self, 
                                    cef_browser_t *browser, 
                                    cef_frame_t *frame, 
                                    cef_v8context_t *context, 
                                    cef_v8exception_t *exception, 
                                    cef_v8stack_trace_t *stackTrace) on_uncaught_exception;

    ///
    // Called when a new node in the the browser gets focus. The |node| value may
    // be NULL if no specific node has gained focus. The node object passed to
    // this function represents a snapshot of the DOM at the time this function is
    // executed. DOM objects are only valid for the scope of this function. Do not
    // keep references to or attempt to access any DOM objects outside the scope
    // of this function.
    ///
    extern(System) void function(   cef_render_process_handler_t* self,
                                    cef_browser_t* browser,
                                    cef_frame_t* frame,
                                    cef_domnode_t* node) on_focused_node_changed;

    ///
    // Called when a new message is received from a different process. Return true
    // (1) if the message was handled or false (0) otherwise. Do not keep a
    // reference to or attempt to access the message outside of this callback.
    ///
    extern(System) int function(    cef_render_process_handler_t* self,
                                    cef_browser_t* browser,
                                    cef_process_id_t source_process,
                                    cef_process_message_t* message) on_process_message_received;
}


}