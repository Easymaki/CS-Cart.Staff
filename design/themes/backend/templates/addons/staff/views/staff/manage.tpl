{capture name="mainbox"}

<form action="{""|fn_url}" method="post" id="staff_form" name="staff_form" enctype="multipart/form-data">
<input type="hidden" name="fake" value="1" />

{include file="common/pagination.tpl"}

{$has_permission = fn_check_permissions("staff", "update_status", "admin", "POST")}

{if $staff}
    {capture name="banners_table"}
        <div class="table-responsive-wrapper longtap-selection">
            <table class="table table-middle table--relative table-responsive">
            <thead>
            <tr>
                <th>{__("first_name")}</th>
                <th>{__("email")}</th>
                <th>{__("post")}</th>
                <th width="6%" class="mobile-hide">&nbsp;</th>
                <th width="10%" class="right">{__("status")}</th>
            </tr>
            </thead>
            {foreach from=$staff item=person}
            <tr class="cm-row-status-{$person.status|lower} cm-longtap-target">
                <td data-th="{__("person")}">
                    <a class="row-status" href="{"staff.update?person_id=`$person.person_id`"|fn_url}">{$person.name}</a>
                    {include file="views/companies/components/company_name.tpl" object=$person}
                </td>
                <td width="10%" class="nowrap row-status mobile-hide">
                    {$person.email}
                </td>
                <td width="10%" class="nowrap row-status mobile-hide">
                    {$person.post}
                </td>
                <td width="6%" class="mobile-hide">
                    {capture name="tools_list"}
                        <li>{btn type="list" text=__("edit") href="staff.update?person_id=`$person.person_id`"}</li>
                    {/capture}
                </td>
                <td width="10%" class="right" data-th="{__("status")}">
                    {include file="common/select_popup.tpl" id=$person.person_id status=$person.status hidden=true object_id_name="person_id" table="staff" popup_additional_class="`$no_hide_input` dropleft"}
                </td>
            </tr>
            {/foreach}
            </table>
        </div>
    {/capture}

    {include file="common/context_menu_wrapper.tpl"
        form="staff_form"
        object="staff"
        items=$smarty.capture.banners_table
        has_permissions=$has_permission
    }
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl"}

{capture name="adv_buttons"}
    {include file="common/tools.tpl" tool_href="staff.add" prefix="top" hide_tools="true" title=__("add_person") icon="icon-plus"}
{/capture}

</form>

{/capture}

{$page_title = __("staff")}
{$select_languages = true}

{include file="common/mainbox.tpl" title=$page_title content=$smarty.capture.mainbox adv_buttons=$smarty.capture.adv_buttons select_languages=$select_languages sidebar=$smarty.capture.sidebar}
