(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit HomeController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /home
     *
     * See Routes/Home/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    THomeController = class(TAbstractController)
    private
        fUserAgent : IUserAgent;
    public
        constructor create(const ua : IUserAgent);
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

    constructor THomeController.create(const ua : IUserAgent);
    begin
        fUserAgent := ua;
    end;

    function THomeController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    begin
        fUserAgent.userAgent := request.env.httpUserAgent();
        response.body().write('<html><head><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" /></head><body>');
        response.body().write('<div>User agent:' + fUserAgent.userAgent + '</div>');
        response.body().write('<div>Home controller from ');

        if fUserAgent.getDevice().isMobile() then
        begin
            response.body().write('mobile ');
        end else
        begin
            response.body().write('desktop ');
        end;

        if fUserAgent.getBrowser().browser['Chrome'] then
        begin
            response.body().write('Chrome ');
        end;

        if fUserAgent.getBrowser().browser['Firefox'] then
        begin
            response.body().write('Firefox ');
        end;

        if fUserAgent.getOS().OS['AndroidOS'] then
        begin
            response.body().write('Android ');
        end;

        if fUserAgent.getOS().OS['iOS'] then
        begin
            response.body().write('iOS ');
        end;

        response.body().write('</div></body></html>');
        result := response;
    end;

end.
