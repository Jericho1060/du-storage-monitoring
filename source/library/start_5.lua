--[[
	Boostrap like css for DU by Jericho1060
]]--
bootstrap_css_grid = [[
	<style>
        .container {
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
	   }
        .row {
		  position:relative;
            display: flex;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px;
        }
        .col-1, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-10, .col-11, .col-12, .col {
            position: relative;
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
        }
        .col {flex-basis: 0;flex-grow: 1;max-width: 100%;}
        .col-auto {flex: 0 0 auto;width: auto;max-width: 100%;}
        .col-1 {flex: 0 0 8.333333%;max-width: 8.333333%;}
        .col-2 {flex: 0 0 16.666667%;max-width: 16.666667%;}
        .col-3 {flex: 0 0 25%;max-width: 25%;}
        .col-4 {flex: 0 0 33.333333%;max-width: 33.333333%;}
        .col-5 {flex: 0 0 41.666667%;max-width: 41.666667%;}
        .col-6 {flex: 0 0 50%;max-width: 50%;}
        .col-7 {flex: 0 0 58.333333%;max-width: 58.333333%;}
        .col-8 {flex: 0 0 66.666667%;max-width: 66.666667%;}
        .col-9 {flex: 0 0 75%;max-width: 75%;}
        .col-10 {flex: 0 0 83.333333%;max-width: 83.333333%;}
        .col-11 {flex: 0 0 91.666667%;max-width: 91.666667%;}
        .col-12 {flex: 0 0 100%;max-width: 100%;}
        .offset-12 {margin-left: 100%;}
        .offset-11 {margin-left: 91.66666667%;}
        .offset-10 {margin-left: 83.33333333%;}
        .offset-9 {margin-left: 75%;}
        .offset-8 {margin-left: 66.66666667%;}
        .offset-7 {margin-left: 58.33333333%;}
        .offset-6 {margin-left: 50%;}
        .offset-5 {margin-left: 41.66666667%;}
        .offset-4 {margin-left: 33.33333333%;}
        .offset-3 {margin-left: 25%;}
        .offset-2 {margin-left: 16.66666667%;}
        .offset-1 {margin-left: 8.33333333%;}
        .offset-0 {margin-left: 0%;}
	</style>
]]
bootstrap_css_colors = [[
	<style>
        .text-white {color: #fff !important;}
        .text-primary {color: #007bff !important;}
        .text-secondary {color: #6c757d !important;}
        .text-success {color: #28a745 !important;}
        .text-info {color: #17a2b8 !important;}
        .text-warning {color: #ffc107 !important;}
        .text-danger {color: #dc3545 !important;}
        .text-light {color: #f8f9fa !important;}
        .text-dark {color: #343a40 !important;}
        .text-body {color: #212529 !important;}
        .text-muted {color: #6c757d !important;}
        .text-black-50 {color: rgba(0, 0, 0, 0.5) !important;}
        .text-white-50 {color: rgba(255, 255, 255, 0.5) !important;}

        .bg-primary {background-color: #007bff !important;}
	   .bg-secondary {background-color: #6c757d !important;}
        .bg-success {background-color: #28a745 !important;}
        .bg-info {background-color: #17a2b8 !important;}
        .bg-warning {background-color: #ffc107 !important;}
        .bg-danger {background-color: #dc3545 !important;}
        .bg-light {background-color: #f8f9fa !important;}
        .bg-dark {background-color: #343a40 !important;}
        .bg-white {background-color: #fff !important;}
        .bg-transparent {background-color: transparent !important;}
	</style>
]]
bootstrap_text_utils = [[
	<style>
        .text-left {text-align: left;}
        .text-right {text-align: right;}
        .text-center {text-align: center;}
        .text-justify {text-align: justify;}
        .text-nowrap {white-space: nowrap;}
        .text-lowercase {text-transform: lowercase;}
        .text-uppercase {text-transform: uppercase;}
        .text-capitalize {text-transform: capitalize;}
	</style>
]]

bootstrap_css = bootstrap_css_grid
        .. bootstrap_css_colors
        .. bootstrap_text_utils