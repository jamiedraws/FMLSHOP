<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.ClientSites.Web.Models" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<BaseClientViewData>" %>
<%

    // Load Group Code
    var groupCode = (ViewData["GroupCode"] as string ?? ViewData["QuestionGroupCode"] as string ?? "SURVEY");

    //Get title text
    var title = ViewData["TitleText"] as string ?? string.Empty;

    //Get survey load type
    var loadType = (ViewData["LoadType"] as string ?? "OnLoad");

    //Get close popup automatically load type
    var closePopAuto = (ViewData["ClosePopAuto"] as string ?? "false");

    //Get Override Css
    var overrideCss = (ViewData["OverrideCss"] as string ?? string.Empty);

    //Get Custom Js Implementation
    var overrideJs = (ViewData["OverrideJs"] as string ?? string.Empty);

    //Get Mustache Template layout
    var questionsLayout = (ViewData["QuestionLayout"] as string ?? "11");

    int questionsLayoutId;
    int.TryParse(questionsLayout, out questionsLayoutId);

    var group = Model.QuestionGroups
            .FirstOrDefault(q => q.Code.Equals(groupCode, StringComparison.InvariantCultureIgnoreCase));

    var surveyGroup = group != null ? new List<CampaignOfferQuestionGroupViewData> { group } : null;

    if (surveyGroup != null)
    {
        // Convert Groups to Javascript Array
        var jsonGroup = JArray.FromObject(surveyGroup, new JsonSerializer
        {
            NullValueHandling = NullValueHandling.Ignore,
            ReferenceLoopHandling = ReferenceLoopHandling.Ignore
        });

%>
<div data-survey-question-group-code="<%=groupCode %>" data-question-group-container="SurveyQuestionGroups"></div>
<style>
    /*	@Layout | Modal Component
    * --------------------------------------------------------------------- */

    @font-face {
        font-family: 'Icomoon';
        src: url(/shared/webfonts/icomoon/icomoon.woff2) format('woff2'), url(/shared/webfonts/icomoon/icomoon.woff) format('woff');
    }

    .c-modal,
    .c-modal * {
        box-sizing: border-box;
    }

    .c-modal,
    .c-modal__overlay {
        position: fixed;
    }

    .c-modal__overlay {
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.8);
        top: 0;
        left: 0;
        z-index: 1;
    }

    .c-modal--is-active .c-modal__overlay,
    .c-modal--is-active .c-modal__fieldset {
        pointer-events: all;
    }

    .c-modal {
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        margin: auto;
        z-index: 10000;
        pointer-events: none;
        flex-direction: column;
        align-items: center;
        font-size: 16px;
    }

    .c-modal,
    .c-modal__fieldset {
        -webkit-overflow-scrolling: touch;
        -ms-overflow-style: -ms-autohiding-scrollbar;
        overflow: auto;
    }

    .c-modal__fieldset {
        background: rgba(237, 237, 237, 0.9);
        border: none;
        font: normal 1em/1.45 Helvetica, sans-serif;
        text-align: center;
        width: 95vw;
        height: auto;
        position: relative;
        z-index: 3;
        padding: 0;
    }

    @media all and ( min-width: 500px ) {
        .c-modal__fieldset {
            width: 75%;
            min-width: 500px;
        }
    }

    .c-modal__group {
        padding: 1.25em;
        margin-top: 2.25em;
    }

    .c-modal__list {
        flex-wrap: wrap;
    }

    .c-modal,
    .c-modal__in,
    .c-modal__list,
    .c-modal__label,
    .c-modal__progress {
        display: flex;
        justify-content: center;
    }

    .c-modal__title {
        color: currentColor;
        padding-bottom: .5em;
        font: normal 1.25em/1.45 Helvetica, sans-serif;
        border-bottom: 1px solid transparent;
    }
    .c-modal__title,
    .c-modal__title__desc,
    .c-modal__item,
    .c-modal__list--textarea__group {
        display: block;
    }

    .c-modal__title--single {
        padding: .5em;
    }

    .c-modal__title__desc {
        font-size: 0.75em;
    }

    .c-modal__grid {
        display: table;
        width: 100%;
    }

    .c-modal__grid__item {
        display: table-cell;
        vertical-align: middle;
        width: 50%;
    }

    .c-modal__label {
        align-items: center;
        padding: 1.3em .65em;
        background: white;
        border: none;
        color: #252525;
        width: 100%;
        height: 100%;
        cursor: pointer;
        position: relative;
        font: inherit;
    }

    .c-modal--standalone .c-modal__fieldset,
    .c-modal--has-answer--textarea .c-modal__label {
        height: auto;
    }

    .c-modal__radio,
    .c-modal__checkbox--close {
        position: absolute;
        opacity: 0;
        top: 0;
        left: 0;
    }

    .c-modal__textarea {
        height: auto;
        border: none;
        border-radius: 0;
        text-align: center;
        border-bottom: 1px solid #b5b5b5;
        line-height: 1.45;
        font-size: 1.15em;
        font-family: inherit;
        padding: 0.5em;
        width: 100%;
        background: white;
    }

    /*
    .c-modal__textarea:hover,
    .c-modal__textarea:focus,
    .c-modal__textarea:focus:valid,
    .c-modal__textarea:focus:invalid {
        background: none;
        background-size: none;
    }
    */

    .c-modal__list--textarea__group {
        margin: 0;
        width: auto;
        padding: 1.25em 0;
    }

    .c-modal__list--submit {
        margin: 1em;
    }

    .c-modal__submit {
        background: #c00;
        color: white;
        padding: 1.25em;
        width: 100%;
        text-align: center;
        border: 0.2em solid #c00;
        font-weight: bold;
        transition: .3s ease-in-out;
    }

    .c-modal .c-modal__submit:focus,
    .c-modal .c-modal__submit:hover {
        background: white;
        color: #c00;
    }

    .c-modal__close {
        display: inline-block;
        position: absolute;
        right: 0;
        font-size: .75em;
        top: 0;
        padding: 0.7em 0.9em;
        background: rgba(90, 90, 90, 0.9);
        color: rgba(255, 255, 255, 0.7);
        line-height: 1;
        cursor: pointer;
    }

    .c-modal__close .icon-cross {
        font-family: 'Icomoon';
        speak: none;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1.5;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    .c-modal__close .icon-cross::before {
        content: "\e90d";
    }

    .c-modal__item {
        margin: 0.25em;
        width: 100%;
        max-height: none;
        position: relative;
    }

    .c-modal__item,
    .c-modal__list--textarea,
    .c-modal .c-modal__list .c-modal--has-answer--textarea {
        flex: 1 1 100%;
    }

    @media all and ( min-width : 600px ) {
        .c-modal__list--2x .c-modal__item,
        .c-modal__list--3x .c-modal__item {
            flex-basis: 45%;
        }
    }

    @media all and ( min-width : 1100px ) {
        .c-modal__list--3x .c-modal__item {
            flex-basis: 30%;
        }
    }


    /*	@Model | Modal Component
    * --------------------------------------------------------------------- */
    /*	Stars
    * --------------------------------------------------------------------- */
    .c-modal__rate {
        /* can control the size */
        font-size: 2.25rem;
        font-size: 2.25em;
        padding: 0 1rem;
    }

    .c-modal__rate__star::before {
        /* can customize the color scheme of the default inactive star */
        color: gray;
    }

    .c-modal__rate__star::after {
        /* can customize the color scheme of the default active star */
        color: #a8ffa8;
    }

    .c-modal__rate__stars,
    .c-modal__rate__star {
        display: flex;
        align-items: center;
    }

    .c-modal__label--rate {
        flex-wrap: wrap;
    }

    @media all and ( max-width : 1080px ) {
        .c-modal__label--rate {
            flex-direction: column;
        }
    }

    .c-modal__rate__star {
        flex: 0 1 0;
        margin: 0.25em;
    }

    .c-modal__rate__star::before,
    .c-modal__rate__star::after {
        display: block;
        overflow: hidden;

        /* can customize the shape */
        content:'\2605';
    }

    .c-modal__rate__star,
    .c-modal__rate__star::before {
        position: relative;
    }

    .c-modal__rate__star::after {
        left: 0;
        right: 0;
        bottom: 0;
        margin: auto;
    }

    .c-modal__rate__radio,
    .c-modal__rate__star::after {
        position: absolute;
        top: 0;
    }

    .c-modal__rate__radio {
        opacity: 0;
    }

    .c-modal__rate--alt .c-modal__rate__star::before {
        z-index: 0;
    }

    .c-modal__rate__star::before,
    .c-modal__rate--alt .c-modal__rate__star::after,

    /* we can set the active stars in the front of the layer stack */
    .c-modal__rate__radio[id^="rate-1"]:checked ~ .c-modal__rate__stars .c-modal__rate__star:nth-child(-n+1)::after,
    .c-modal__rate__radio[id^="rate-2"]:checked ~ .c-modal__rate__stars .c-modal__rate__star:nth-child(-n+2)::after,
    .c-modal__rate__radio[id^="rate-3"]:checked ~ .c-modal__rate__stars .c-modal__rate__star:nth-child(-n+3)::after,
    .c-modal__rate__radio[id^="rate-4"]:checked ~ .c-modal__rate__stars .c-modal__rate__star:nth-child(-n+4)::after,
    .c-modal__rate__radio[id^="rate-5"]:checked ~ .c-modal__rate__stars .c-modal__rate__star:nth-child(-n+5)::after {
        z-index: 1;
    }


    /*	Loader
    * --------------------------------------------------------------------- */
    #loader .c-modal__fieldset {
        padding: 1.8em 0;
    }

    .c-modal__progress > span,
    .c-modal__progress::before,
    .c-modal__progress::after {
        display: block;
        width: 1em;
        height: 1em;
        font-size: .65em;
        background: #bfa8ff;
        border-radius: 100%;
        position: relative;
    }

    .c-modal--is-active .c-modal__progress > span,
    .c-modal--is-active .c-modal__progress::before,
    .c-modal--is-active .c-modal__progress::after {
        animation: bounce 1.25s infinite;
    }

    .c-modal--is-active .c-modal__progress > span {
        animation-delay: 0.4s;
    }

    .c-modal--is-active .c-modal__progress::after {
        animation-delay: 0.8s;
    }

    .c-modal__progress::before,
    .c-modal__progress::after {
        content: '';
    }

    .c-modal__progress::before {
        right: 1%;
    }

    .c-modal__progress::after {
        left: 1%;
    }

    @keyframes bounce {
        0%, 69% {
            transform: scale(1,1) translateY(0);
        }

        70% {
            transform: scale(1,0.8) translateY(25%);
        }

        85% {
            transform: scale(1,1.1) translateY(-50%);
        }

        100% {
            transform: scale(1,1) translateY(0);
        }
    }


    /*	@State | Modal Component
    * --------------------------------------------------------------------- */
    .c-modal__label,
    .c-modal__title,
    .c-modal__textarea,
    .c-modal__close,
    .c-modal__has-nav,
    .c-modal--is-post-submit .c-modal__has-nav {
        transition: all 150ms ease-in-out;
    }

    .c-modal--is-selected .c-modal__title {
        border-bottom-color: #b5b5b5;
    }

    .c-modal--is-hidden {
        display: none;
    }

    .c-modal__item,
    .c-modal--is-selected .c-modal__item:not(.c-modal--is-selected) {
        opacity: 0;
        transition: all 150ms ease-in-out;
    }

    .c-modal__overlay,
    .c-modal__fieldset {
        transition:
            opacity 150ms ease-in-out,
            background 150ms ease-in-out;
    }

    .c-modal--is-active .c-modal__overlay,
    .c-modal--is-active .c-modal__fieldset,
    .c-modal--is-active,
    .c-modal--is-active .c-modal__item {
        opacity: 1;
    }

    .c-modal__overlay,
    .c-modal__fieldset,
    .c-modal__checkbox--close:checked ~ .c-modal__overlay,
    .c-modal__checkbox--close:checked ~ .c-modal__fieldset {
        opacity: 0;
        pointer-events: none;
    }

    .c-modal--is-active .c-modal__item:nth-child(odd),
    .c-modal--is-active .c-modal__item:nth-child(even) {
        transform: translateX(0);
        transition-delay: 300ms;
    }

    .c-modal--is-active .c-modal__fieldset,
    .c-modal--is-active .c-modal__item:last-child:nth-child(odd) {
        transform: translateY(0);
    }

    .c-modal__fieldset {
        transform: translateY(-30%);
    }

    .c-modal__item:nth-child(odd),
    .c-modal--is-selected .c-modal__item:not(.c-modal--is-selected):nth-child(odd) {
        transform: translateX(-10%);
    }

    .c-modal__item:nth-child(even),
    .c-modal--is-selected .c-modal__item:not(.c-modal--is-selected):nth-child(even) {
        transform: translateX(10%);
    }

    .c-modal__item:last-child:nth-child(odd),
    .c-modal--is-selected .c-modal__item:not(.c-modal--is-selected):last-child:nth-child(odd) {
        transform: translateY(30%);
    }

    .c-modal--is-selected .c-modal__item:not(.c-modal--is-selected) {
        transition-delay: 100ms;
    }

    .c-modal--is-hidden-and-out {
        display: block;
        max-height: 0;
        margin: 0;
        pointer-events: none;
    }

    .c-modal--is-expanded {
        width: 98%;
    }

    .c-modal--is-expanded .c-modal__label {
        background: transparent;
        color: #252525;
        cursor: default;
    }

    .c-modal--is-selected .c-modal__has-nav {
        max-height: 4em;
        transition-delay: 650ms;
    }

    .c-modal__has-nav,
    .c-modal--is-post-submit .c-modal__has-nav {
        max-height: 0;
        overflow: hidden;
    }

    .c-modal--is-selected .c-modal__close {
        pointer-events: none;
    }

    .c-modal__close:hover {
        background: rgba(255, 255, 255, 0.7);
        color: rgba(90, 90, 90, 0.9);
    }

    .c-modal__label:hover,
    .c-modal__label:focus,
    .c-modal__radio:focus ~ .c-modal__label {
        background: rgba(236, 236, 236, 0.95);
    }

    .c-modal__radio:checked ~ .c-modal__label {
        color: #065606;
        background: #a8ffa8;
    }

    .c-modal__list--textarea {
        pointer-events: none;
        visibility: hidden;
        position: absolute;
    }

    .c-modal__textarea {
        opacity: 0;
        transform: translateY(-20%);
        transition:
            opacity 0.3s cubic-bezier(0.075, 0.82, 0.165, 1),
            transform 0.7s cubic-bezier(0.075, 0.82, 0.165, 1);
    }

    .c-modal__radio:checked ~ .c-modal__list--textarea,
    .c-modal__group[role="textbox"] .c-modal__list--textarea {
        pointer-events: all;
        visibility: visible;
        position: relative;
    }

    .c-modal__radio:checked ~ .c-modal__list--textarea .c-modal__textarea,
    .c-modal__group[role="textbox"] .c-modal__list--textarea .c-modal__textarea {
        opacity: 1;
        transform: translateY(0);
    }

    .c-modal--is-texting .c-modal__fieldset {
        background: rgba(86, 86, 86, 0.8);
    }

    .c-modal--is-texting .c-modal__fieldset,
    .c-modal--is-texting .c-modal__textarea {
        color: white;
    }

    .c-modal .validation-summary-errors {
        padding: 0.5em;
        background: #FF7373;
        color: #7F120F;
        border: 2px solid #7f120f;
        display: block;
        width: 100%;
        margin-bottom: 0.5em;
    }

    .c-modal .validation-summary-errors > span {
        padding: 0;
        border: none;
    }

    <%= overrideCss %>

</style>
<script type="text/javascript" src="/shared/js/mustache.js"></script>

<%= DtmContext.Layouts
       .Where(l => l.Id == questionsLayoutId)
       .Select(l => l.Html)
       .FirstOrDefault() %>

<script>
    var surveyEngine = function () {
        //Private Variables
        var self = this;
        var config = {};
        var questions = [];
        var preSubmitResponse = {};
        var postSubmitResponse = {};
        var triggerEvent = window.triggerEvent || function triggerEvent(eventName, data, element) {
            try {
                var event;
                var payload = (data && typeof (data.detail) != "undefined")
                    ? data
                    : (data ? { detail: data } : { detail: '' });
                if (typeof window.CustomEvent === 'function') {
                    event = new CustomEvent(eventName, payload || { detail: '' });
                } else if (document.createEvent) {
                    event = document.createEvent('HTMLEvents');
                    event.detail = payload.detail;
                    event.initEvent(eventName, true, true);
                } else if (document.createEventObject) {
                    event = document.createEventObject();
                    event.detail = payload.detail;
                    event.eventType = eventName;
                }
                event.eventName = eventName;
                var el = element || window;
                if (el.dispatchEvent) {
                    el.dispatchEvent(event);
                } else if (el.fireEvent && htmlEvents[eventName]) {
                    el.fireEvent(event.eventType, event);
                } else if (el[eventName]) {
                    el[eventName]();
                } else if (el['on' + eventName]) {
                    el['on' + eventName]();
                }
            } catch (error) {
                console.log('Error executing ' + name + ' Event');
            }
        };

        // Private Methods

        /**
         * Will run specific logic from the typeFunctions passed in based on Question InputTypeCode
         * @param typeFunctions
         */
        var runQuestionTypeLogic = function (typeFunctions) {
            var functions = new typeFunctions();
            if (typeof questions !== 'undefined') {
                questions.forEach(function (element) {
                    switch (element.InputTypeCode.toUpperCase()) {
                        case 'RADIO':
                            if (typeof (functions.radioLogic) == 'function') {
                                functions.radioLogic(element);
                            }
                            break;
                        case 'CHECKBOX':
                            if (typeof (functions.checkboxLogic) == 'function') {
                                functions.checkboxLogic(element);
                            }
                            break;
                        case 'TEXTBOX':
                            if (typeof (functions.textareaLogic) == 'function') {
                                functions.textboxLogic(element);
                            }
                            break;
                        case 'TEXTAREA':
                            if (typeof (functions.textareaLogic) == 'function') {
                                functions.textareaLogic(element);
                            }
                            break;
                        case 'RATE':
                            if (typeof (functions.rateLogic) == 'function') {
                                functions.rateLogic(element);
                            }
                            break;
                    }
                });
            }
        };

        /**
         * SurveyTemplate
         * allows questions to be added using the Mustache.js library into the DOM
        */
        var SurveyTemplate = function (_reference, _$element) {
            var self = this;

            // bounce out if a modal shell is not provided and inform the dev what we need
            if (typeof _reference === 'undefined' || typeof _$element === 'undefined') {
                throw Error('A reference and $element. parameter is required to build the modal shell. Please provide a string name and a jQuery selector.');
            }

            // cache the body selector
            this.$body = $('body');
            // sets the storage to cache selectors that we can access
            this.select = {};
            // sets the storage to cache templates that we can access
            this.template = {};
            // sets the default template to be used in mustache - this can be overriden after instantiation
            this.templateDefault = $('#modal__radioGroup').html();

            /**
             * displayModal
             * shows/hides the modal
             * @param {Node, Boolean}
             *  - $modal : the modal that we want to request
             *  - visible : the boolean that determines if the modal should be visible or hidden
            */
            this.displayModal = function ($modal, visible) {
                if (typeof visible !== 'boolean') return;
                var updateClass = visible ? 'addClass' : 'removeClass';
                $modal[updateClass]('c-modal--is-active');
            };

            /**
             * addTemplate
             * takes a node object, fetches the html and sets it as a new property
             * @param {String, Node, Boolean}
             *  - reference : the property name to access the template
             *  - $element : the node to fetch the html
             *  - setDefault : the boolean that determines if the template should be the default template
            */
            this.addTemplate = function (reference, $element, setDefault) {
                this.template[reference] = $element.html();
                if (typeof setDefault === 'boolean' && setDefault) {
                    this.templateDefault = this.template[reference];
                }
            };

            /**
             * addQuestions
             * returns a promise for when all of the questions have been parsed into a single html response
             * @param {Object} - groups : the group of questions to be rendered into html
            */
            this.addQuestions = function (groups) {
                var promise = $.Deferred(), $html = '', last = groups.length - 1;
                $.each(groups, function (i, group) {
                    var template = 'addTemplate' in group ? group.addTemplate : self.templateDefault;
                    $html += Mustache.to_html(template, group.addQuestion);
                    if (last === i) {
                        promise.resolve($html);
                    }
                });
                return promise.promise();
            };

            /**
             * addResponse
             * returns a promise for when the response has been parsed into an html response
             * @param {Object} - group : the group containing the response and the optional template
            */
            this.addResponse = function (group) {
                var promise = $.Deferred();
                if ('id' in group.addResponse) {
                    var id = group.addResponse.id;
                    // if this template is not already in the DOM, let's put it in there and cache the selector for later
                    if ($('#' + id).length === 0) {
                        var template = 'addTemplate' in group ? group.addTemplate : self.templateDefault,
                            $html = Mustache.to_html(template, group.addResponse);

                        this.$body.append($html);
                        this.select[id] = $('#' + id);
                    }
                    // and then let's give back the reference to the template
                    promise.resolve(this.select[id]);
                } else {
                    // we can't do anything without an id so reject this and let the dev know why
                    promise.reject('The id is required to access a pre-existing template or create a new template');
                }

                return promise.promise();
            };

            this.build = function () {
                var promise = $.Deferred();
                // first, add the template for the modal shell
                this.addTemplate(_reference, _$element);
                this.addResponse({
                    addTemplate: this.template[_reference],
                    addResponse: {
                        id: 'survey',
                        TitleText: "<%=title%>",
                        ShowTitleText: "<%=title%>" != "" ? true : false
                    }
                }).then(function ($reference) {
                    // sets default container - this can be overridden after instantiation
                    self.container = $reference.find('#modal__in');
                    promise.resolve(self.container);
                });

                return promise.promise();
            };
        };

        /**
         * Question object used when creating survey
         * @param id
         * @param answer
         */
        var Question = function (id, answer) {
            this.Id = id;
            this.Answer = answer;
        };

        /**
         * Survey object used when creating survey
         * @param visitorSessionId
         */
        var Survey = function (visitorSessionId) {
            var self = this;
            this.VisitorSessionId = visitorSessionId;
            this.Questions = new Array();

            this.AddQuestionAnswer = function (id, answer) {
                self.Questions[self.Questions.length] = new Question(id, answer);
            };
        };

        /**
         * Creates Survey object and defines logic used to get survey answers
         */
        var createSurvey = function () {
            var survey = new Survey('<%= DtmContext.VisitorSessionId.ToString() %>');

            var addSurveyQuestion = function (id, value) {
                if ((typeof (id) != "undefined" && id != "")
                    && (typeof (value) != "undefined" && value != "")) {
                    survey.AddQuestionAnswer(id, value);
                }
            };

            //logic used to get survey answers based on Question Type
            var questionsLogic = function () {
                this.radioLogic = function (element) {
                    var name = element.SurveyQuestionId;
                    var answerInput = $("[name='" + name + "']:checked");
                    var answer = answerInput.val();
                    if (typeof answerInput.attr("id") !== 'undefined' && answerInput.attr("id").match(/OTHER/i)) {
                        var answerCode = answerInput.attr("id");
                        answer = answer + " - " + $("[name='otherText" + name + "'][data-survey-code='" + answerCode + "']").val();
                    }
                    addSurveyQuestion(name, answer);
                };
                this.checkboxLogic = function (element) {
                    var name = element.SurveyQuestionId;
                    var answer = "";
                    $("[name*='" + name + "']:checked").each(function () {
                        if ($(this).attr("id").match(/OTHER/i)) {
                            answer += $("[name='otherText" + name + "']").val() + ",";
                        } else {
                            answer += $(this).val() + ",";
                        }
                    });
                    addSurveyQuestion(name, answer);
                };
                this.textareaLogic = function (element) {
                    var name = element.SurveyQuestionId;
                    addSurveyQuestion(name, $("#" + name).val());
                };
                this.textboxLogic = function (element) {
                    var name = element.SurveyQuestionId;
                    addSurveyQuestion(name, $("#" + name).val());
                };
                this.rateLogic = function (element) {
                    element.Answers.forEach(function (element) {
                        var name = element.SurveyQuestionId;
                        var answer = $("[name='" + name + "']:checked").val();
                        addSurveyQuestion(name, answer);
                    });
                };
            };

            runQuestionTypeLogic(questionsLogic)

            return survey;
        };
        var preSubmit = function (submitButton) {
            // display the loader while we process the survey - flip the classes when we want to hide the loader
            postOrderSurvey.addResponse({
                addTemplate: postOrderSurvey.template.response,
                addResponse: preSubmitResponse
            }).then(function ($reference) {
                postOrderSurvey.displayModal($reference, true);
                $reference.find('[tabindex]:first').focus();
            });
        };
        //End Private Methods

        //Public Methods
        this.postSubmit = function () {
            postOrderSurvey.addResponse({
                addTemplate: postOrderSurvey.template.response,
                addResponse: postSubmitResponse
            }).then(function ($reference) {
                setTimeout(function () {
                    postOrderSurvey.displayModal($reference, true);
                    $reference.find('[tabindex]:first').focus();
                }, 1500);
            });
        };

        this.closeSurveyForm = function () {
            if (typeof (postOrderSurvey.select.success) != 'undefined') {
                postOrderSurvey.displayModal(postOrderSurvey.select.success, false);
            }

            if (typeof (postOrderSurvey.select.loader) != 'undefined') {
                postOrderSurvey.displayModal(postOrderSurvey.select.loader, false);
            }

            if (typeof (postOrderSurvey.select.survey) != 'undefined') {
                postOrderSurvey.displayModal(postOrderSurvey.select.survey, false);
            }
        };

        this.handleSurveySubmit = function (submitButton) {

            triggerEvent("SurveyQuestionValidation");

            //Use this function name to add custom validation.
            //Make sure to use .custom - vse to display errors
            if (typeof surveyCustomValidation == 'function') {
                 surveyCustomValidation();
            }

            var errorCount = 0;
            $('.custom-vse').each(function (idx, ele) {
                if ($(this).html().length > 0) {
                    errorCount++;
                }
            });
            if (errorCount > 0) {
                return;
            }


            var survey = createSurvey();
            preSubmit(submitButton);
            $.post('/Shared/Services/SurveyService.ashx', { survey: JSON.stringify(survey) }, function () {
                self.postSubmit();
                if (document.cookie.indexOf('<%=groupCode%>-surveySubmitted=') == -1) {

                    var expireDays = typeof expirationDays === "undefined" ? 1 : expirationDays;

                    self.setCookie("<%=groupCode%>-surveySubmitted", "1", expireDays);

                    if ("<%=closePopAuto.ToLower()%>" == "true") {
                        //Autoclose after three seconds
                        setTimeout(function () {
                            self.closeSurveyForm();
                        }, 3000);

                    }

                }
            }).fail(function (err) {
                postOrderSurvey.displayModal(postOrderSurvey.select.loader, false);
            });
        };

        this.displaySurvey = function () {
            postOrderSurvey.displayModal(postOrderSurvey.select.survey, true);
            // for accessibility, focus on the first tabindex which will be the close button, giving the user first chance to opt-out of the survey
            postOrderSurvey.select.survey.find('[tabindex]:first').focus();
        }

        this.surveyQuestion = function (data, questionGroup) {
            var self = this;
            self.Type = 'Question';
            self.Id = data.Id || '';
            self.Code = data.Code || '';
            self.Text = data.Text || '';
            self.SurveyQuestionId = data.Details || '';
            self.Placeholder = data.Placeholder || '';
            self.ViewDataValue = data.ViewDataValue || '';
            self.Answers = [];
            self.DisplayRank = data.DisplayRank || '';
            self.IsRequired = (data.ErrorMessage != null && data.ErrorMessage.length > 0) ? true : false;
            self.InputTypeId = data.InputTypeId || '';
            self.ValidationRegex = data.ValidationRegex || '';
            self.ErrorMessage = data.ErrorMessage || '';
            self.AnswerDataTypeId = data.AnswerDataTypeId || '';
            self.AnswerMinValue = data.AnswerMinValue || '';
            self.AnswerMaxValue = data.AnswerMaxValue || '';
            self.CampaignOfferQuestionGroupId = data.CampaignOfferQuestionGroupId || '';
            self.InputTypeCode = data.InputTypeCode || {};
            self.AnswerDataTypeName = data.AnswerDataTypeName || {};
            self.QuestionGroup = questionGroup || {};

            self.Required = function () {
                return self.IsRequired ? 'required' : '';
            };

            self.InputType = function () {
                switch (self.AnswerDataTypeName) {
                    case "Integer":
                    case "Float":
                    case "Decimal":
                    case "Double":
                        return "number";
                    case "Boolean":
                        return "checkbox";
                    case "DateTime":
                        return "datetime";
                    case "Date":
                        return "date";
                    case "Image":
                        return "file";
                }
                return "text";
            };

            self.throwError = function (element, errorMessage) {
                const container = document.createElement("span");
                container.classList.add("validation-summary-errors");
                container.textContent = errorMessage;

                element.appendChild(container);
                element.classList.remove("hide");
            };

            self.destroyError = function (element) {
                const container = element.querySelector(".validation-summary-errors");
                if (container && container.parentNode && container.parentNode === element) {
                    element.removeChild(container);
                }
            }

            self.Validation = function () {
                var type = self.InputTypeCode;
                var errorMessage = self.ErrorMessage;
                var code = self.Code;
                var questionId = self.SurveyQuestionId;
                var regexValue = self.ValidationRegex || '^.{1,50}$';

                registerEvent("SurveyQuestionValidation", function (e) {
                    const vse = document.querySelector('#Vse_Question_' + code + '');
                    self.destroyError(vse);

                    switch (type.toUpperCase()) {
                        case 'RADIO':
                            if (!$('input[name=' + questionId + ']').is(':checked')) {
                                self.throwError(vse, errorMessage);
                                vse.scrollIntoView();
                            }
                            else if ($('[Name="'+ questionId +'"]:checked').val().toUpperCase() == "OTHER") {
                                var value = $('textarea[name=otherText' + questionId +']').val();
                                if (!value) {
                                    errorMessage = 'Please enter an answer for the option "Other"';
                                    self.throwError(vse, errorMessage);
                                    vse.scrollIntoView();
                                }
                            }
                            break;
                        case 'CHECKBOX':
                            let hasChecked = false;
                            $('input[name=' + questionId + ']').each(function (idx, ele) {
                                if ($(this).is(':checked')) {
                                    hasChecked = true;
                                    return false;
                                }
                            });
                            if (!hasChecked) {
                                self.throwError(vse, errorMessage);
                                vse.scrollIntoView();
                            }
                            break;
                        case 'TEXTBOX':
                            var value = $('textarea[name=' + questionId + ']').val();
                            var regex = new RegExp(regexValue);

                            if (value.length < 1) {
                                self.throwError(vse, errorMessage);
                                vse.scrollIntoView();
                            }
                            else if (!regex.test(value)) {
                                self.throwError(vse, errorMessage);
                                vse.scrollIntoView();
                            }
                            break;

                    }
                });
            }

            function init() {
                if (data.Answers) {
                    for (var j = 0; j < data.Answers.length; j++) {
                        self.Answers.push(new _surveyEngine.surveyQuestionAnswer(data.Answers[j], self));
                    }
                }
            }

            init();
        };

        this.removeCookie = function () {
            document.cookie = "<%=groupCode%>-surveySubmitted=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
        };

        this.setCookie = function (cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toUTCString();
            document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
        };

        this.surveyQuestionAnswer = function (data, question) {
            var self = this;
            self.Type = 'Answer';
            self.Id = data.Id || '';
            self.Code = data.Code || '';
            self.Text = data.Text || '';
            self.Placeholder = data.Details || '';
            self.DisplayRank = data.DisplayRank || '';
            self.AddTextArea = data.Code == 'OTHER' || data.Code.match(/OTHER/i);
            self.Question = question || {};
        };

        this.init = function (config) {

            //Load Questions from QuestionGroups
            var surveyQuestionGroup = <%= jsonGroup %>;
            var surveyQuestions = {};
            for (var i = 0; i < surveyQuestionGroup.length; i++) {
                surveyQuestions = surveyQuestionGroup[i].Questions;
            }

            console.log('Loading Survey Question Groups');

            for (var surveyQuestion in surveyQuestions) {
                var html = '';
                var question = new _surveyEngine.surveyQuestion(surveyQuestions[surveyQuestion]);

                questions.push(question);
            }


            // we for sure need questions. if we don't have questions, what's the point of having a survey?
            if (questions.length == 0) {
                throw Error('The survey engine requires questions to display. Please provide the questions.');
            }

            //Run custom function allowing you to manipulate questions before rendered by mustache templates
            if (typeof config.editQuestionsObject === 'function') {
                questions = config.editQuestionsObject(questions);
            }

            // let's be nice and provide a default pre-submit response - it doesn't HAVE to be required
            if (typeof config.preSubmitResponse === 'function') {
                preSubmitResponse = config.preSubmitResponse();
            } else {
                preSubmitResponse = {
                    id: 'loader',
                    title: 'Processing',
                    progress: true
                };
            }

            // and of course provide a default post-submit response too, because that's nice too
            if (typeof config.postSubmitResponse === 'function') {
                postSubmitResponse = config.postSubmitResponse();
            } else {
                postSubmitResponse = {
                    id: 'success',
                    title: 'Thank You!',
                    close: true
                };
            }

            // let's instantiate a new survey template with the shell and expose to the global window
            window.postOrderSurvey = new SurveyTemplate('shell', $('#modal__shell'));

            /**
             * can use this if we want to override the default template
             * postOrderSurvey.addTemplate('radioGroup', $('#modal__radioGroup'), true);
            */

            //Add custom templates if we have any else let's add our default templates
            if (typeof config.templates === 'object') {
                $.each(config.templates, function () {
                    postOrderSurvey.addTemplate(this.reference, $(this.element), this.isDefault);
                });
            } else {
                postOrderSurvey.addTemplate('response', $('#modal__response'));
                postOrderSurvey.addTemplate('checkboxGroup', $('#modal__checkboxGroup'));
                postOrderSurvey.addTemplate('textbox', $('#modal__textbox'));
                postOrderSurvey.addTemplate('textarea', $('#modal__textarea'));
                postOrderSurvey.addTemplate('rate', $('#modal__rate'));
            }

            var surveyTemplateQuestions = [];

            var questionsLogic = function () {
                this.radioLogic = function (element) {
                    surveyTemplateQuestions.push({
                        addQuestion: element
                    });
                };
                this.checkboxLogic = function (element) {
                    surveyTemplateQuestions.push({
                        addTemplate: postOrderSurvey.template.checkboxGroup,
                        addQuestion: element
                    });
                };
                this.textareaLogic = function (element) {
                    surveyTemplateQuestions.push({
                        addTemplate: postOrderSurvey.template.textarea,
                        addQuestion: element
                    });
                };
                this.textboxLogic = function (element) {
                    surveyTemplateQuestions.push({
                        addTemplate: postOrderSurvey.template.textbox,
                        addQuestion: element
                    });
                };
                this.rateLogic = function (element) {
                    surveyTemplateQuestions.push({
                        addTemplate: postOrderSurvey.template.rate,
                        addQuestion: element
                    });
                };

            };

            runQuestionTypeLogic(questionsLogic);

            // and then, let's add our questions in
            $.when(postOrderSurvey.build()).done(function () {
                postOrderSurvey.addQuestions(surveyTemplateQuestions).done(function ($html) {
                    // once all the questions have been collected and parsed into the html response, add it to the DOM once
                    postOrderSurvey.container.html($html);
                    // postOrderSurvey.select.survey.find('textarea').on({
                    //     focusin: function () {
                    //         postOrderSurvey.select.survey.addClass('c-modal--is-texting');
                    //     },
                    //     focusout: function () {
                    //         postOrderSurvey.select.survey.removeClass('c-modal--is-texting');
                    //     }
                    // });
                })
            });

            // allow user to close the success modal natively, but also make sure to unselect the checkbox and hide the modal
            postOrderSurvey.$body.on('change', '#modal__success__close', function () {
                self.closeSurveyForm();
                $(this).prop('checked', false);
            });

            postOrderSurvey.$body.on('keyup', 'label[for="modal__success__close"]', function (evt) {
                // if user presses enter key (13) or space bar (32)
                if (evt.keyCode === 13 || evt.keyCode === 32) self.closeSurveyForm();
            });

            //Bind Events
            postOrderSurvey.select.survey.find('#surveySubmit').on('click', self.handleSurveySubmit);
            postOrderSurvey.$body.on('click', '.c-modal__close', self.closeSurveyForm);
        };
        //End Public Methods
    };

    // instantiate a new survey engine
    var _surveyEngine = new surveyEngine();

    //Load Survey and pass in overrides
    function InitializeSurvey() {
        var surveyConfiguration = {};

        if (typeof (PreSubmitResponse) === 'function') {
            surveyConfiguration.preSubmitResponse = PreSubmitResponse;
        }

        if (typeof (EditQuestionsObject) === 'function') {
            surveyConfiguration.editQuestionsObject = EditQuestionsObject;
        }

        if (typeof (PostSubmitResponse) === 'function') {
            surveyConfiguration.postSubmitResponse = PostSubmitResponse;
        }

        if (typeof (templates) !== 'undefined') {
            surveyConfiguration.templates = templates;
        }

        _surveyEngine.init(surveyConfiguration);
    }


    <%= overrideJs %>
    var fireIdle = true;
    var fireSurvey = true;

    $(document).ready(function () {

        if (typeof (InitializeSurveyCustom) === 'function') {
            InitializeSurveyCustom();
        } else {
            InitializeSurvey();
        }
        var loadType = '<%=loadType%>'; // add different load times here


    //disable ExitPop for Testing
    <% string currentUrl = Request["exitpop"];
    if (currentUrl != "0")
    { %>

        if (document.cookie.indexOf('<%=groupCode%>-surveySubmitted=') == -1) {

            registerEvent('CancelSurveyFire', function (e) {
                fireSurvey = false;
                fireIdle = false;
            });

        switch (loadType) {

            case "Timeout":
                var idleThreshold = "<%=ViewData["IdleThreshold"]%>" ;
                var idle = parseInt(idleThreshold);

                if(!isNaN(idle)){
                    var seconds = idle * 1000;

                    setTimeout(function () {

                        if (fireSurvey) {
                            _surveyEngine.displaySurvey();
                        }

                    }, seconds); // 1000ms = 1 second
                    break;
                }
            case "Idle":
                //if form interaction , don't show survey
                $('form input').on('click change keyup focus', function () {
                    fireSurvey = false;
                    fireIdle = false;
                });

                addIdleEvent();

                break;
            case "ExitIntent":
                addExitEvent(true);
                break;
            case "IdleExitIntent":

                //if form interaction , don't show survey
                $('form').on('click change keyup focus', function () {
                    fireIdle = false;
                });

                addIdleEvent();

                setTimeout(function () {

                    addExitEvent(true, true);

                }, 10000);

                break;
            case "DelayedIdleExitIntent":


                //if form interaction , don't show survey
                $('form').on('click change keyup focus', function () {
                    fireIdle = false;
                });

                addIdleEvent();

                setTimeout(function () {

                    addExitEvent(true, true);

                }, 10000);

                break;
            case "OnLoad":
                _surveyEngine.displaySurvey();
                break;
        }
    }
    <%}%>

        if (typeof expirationDays === "undefined") {
            $('#AcceptOfferButton, [name=createOrder]').on("click", _surveyEngine.removeCookie);


        } else {
            if (document.cookie.indexOf('<%=groupCode%>-surveySubmitted=') == -1) {
                $('#AcceptOfferButton, [name=createOrder]').on('click', function () {
                    _surveyEngine.setCookie("<%=groupCode%>-surveySubmitted", "1", expirationDays);
                });
            }
        }
    });

    function addIdleEvent() {
        var idleThreshold = "<%=ViewData["IdleThreshold"]%>";
        var idle = parseInt(idleThreshold);
        if (!isNaN(idle)) {
            var seconds = idle * 1000;

            setTimeout(function () {

                if (fireIdle) {
                    _surveyEngine.displaySurvey();
                    fireSurvey = false;
                    fireIdle = false;
                }

            }, seconds);
        }
    }

    var mouseLeave = false;
    window.dtm_surveyMouseState = "";
    function addExitEvent(checkHeight, delay) {

        document.documentElement.addEventListener("mouseleave", function (e) {
            window.dtm_surveyMouseState = "left";
                if (!checkHeight || e.clientY < 20) {

                    if (fireSurvey) {
                        if (delay) {
                            setTimeout(function () {

                                if (window.dtm_surveyMouseState && window.dtm_surveyMouseState == "left") {
                                    _surveyEngine.displaySurvey();
                                    fireSurvey = false;
                                    fireIdle = false;
                                }
                            }, 500);
                        } else {
                            _surveyEngine.displaySurvey();
                            fireSurvey = false;
                            fireIdle = false;
                        }
                        
                    }
                }
        }, false);

        document.documentElement.addEventListener("mouseenter", function (e) {
            window.dtm_surveyMouseState = "enter";
        }, false);
    }

</script>

    <% }
    else
    {
        new SiteExceptionHandler("No SurveyGroup found");
    }%>