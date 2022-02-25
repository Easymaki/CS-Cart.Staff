{if $person}
    {assign var="id" value=$person.person_id}
{else}
    {assign var="id" value=0}
{/if}

{$allow_save = $person|fn_allow_save_object:"staff"}
{assign var="b_type" value=$person.type|default:"G"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" class="form-horizontal form-edit{if !$allow_save || $hide_inputs} cm-hide-inputs{/if}" name="staff_form" enctype="multipart/form-data">
<input type="hidden" class="cm-no-hide-input" name="fake" value="1" />
<input type="hidden" class="cm-no-hide-input" name="person_id" value="{$id}" />

{capture name="tabsbox"}
    <div id="content_general">
        <div class="control-group">
            <label for="elm_person_name" class="control-label cm-required">{__("first_name")}</label>
            <div class="controls">
            <input type="text" name="person_data[name]" id="elm_person_name" value="{$person.name}" size="25" class="input-large" /></div>
        </div>
        <div class="control-group" id="staff_graphic">
            <label class="control-label">{__("image")}</label>
            <div class="controls">
            {include file="common/attach_images.tpl"
                image_name="staff_main"
                image_object_type="staff"
                image_pair=$person.main_pair
                image_object_id=$id
                no_detailed=true
                hide_titles=true
            }
            </div>
        </div>
        <div class="control-group" id="person_post">
            <label class="control-label" for="elm_person_post">{__("post")}:</label>
            <div class="controls">
                <input type="text" name="person_data[post]" id="elm_person_post" value="{$person.post}" size="25" class="input-large" />
            </div>
        </div>
        <div class="control-group">
            <label for="elm_person_gender" class="control-label">{__("gender")}</label>
            <div class="controls">
            <select name="person_data[gender]" id="elm_person_gender">
                <option {if $person.gender == "M"}selected="selected"{/if} value="M">{__("male")}</option>
                <option {if $person.gender == "F"}selected="selected"{/if} value="F">{__("female")}</option>
            </select>
            </div>
        </div>
        <div class="control-group" id="person_text">
            <label class="control-label" for="elm_person_description">{__("short_description")}:</label>
            <div class="controls">
                <textarea id="elm_person_description" name="person_data[description]" cols="35" rows="8" class="cm-wysiwyg input-large">{$person.description}</textarea>
            </div>
        </div>
        <div class="control-group" id="person_country">
            <label class="control-label" for="elm_person_country">{__("country")}:</label>
            <div class="controls">
                <select class="cm-state" id="elm_person_country" name="person_data[country]">
                {foreach from=$countries.0 item=country}
                    <option {if $country.code == $person.country}selected="selected"{/if} value="{$country.code}">{$country.country}</option>
                {/foreach}
                </select>
            </div>
        </div>
        <div class="control-group" id="person_state">
            <label class="control-label" for="elm_person_state">{__("state")}:</label>
            <div class="controls">
                <select class="cm-state" id="elm_person_state" name="person_data[state]">
                {foreach from=$states.0 item=state}
                {if $state.country_code == $person.country}
                    <option {if $state.code == $person.state}selected="selected"{/if} value="{$state.code}">{$state.state}</option>
                {/if}
                {/foreach}
                </select>
            </div>
        </div>
        <div class="control-group" id="person_city">
            <label class="control-label" for="elm_person_city">{__("city")}:</label>
            <div class="controls">
                <input type="text" name="person_data[city]" id="elm_person_city" value="{$person.city}" size="25" class="input-large" />
            </div>
        </div>
        <div class="control-group" id="person_adress">
            <label class="control-label" for="elm_person_adress">{__("address")}:</label>
            <div class="controls">
                <input type="text" name="person_data[adress]" id="elm_person_adress" value="{$person.adress}" size="25" class="input-large" />
            </div>
        </div>
        <div class="control-group" id="person_position">
            <label class="control-label" for="elm_person_position">{__("position")}:</label>
            <div class="controls">
                <input type="text" name="person_data[position]" id="elm_person_position" value="{$person.position}" size="15" class="input-large" />
            </div>
        </div>

        {include file="common/select_status.tpl" input_name="person_data[status]" id="elm_person_status" obj_id=$id obj=$person hidden=true}


{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}

{capture name="buttons"}
    {if !$id}
        {include file="buttons/save_cancel.tpl" but_role="submit-link" but_target_form="staff_form" but_name="dispatch[staff.update]"}
    {else}
        {include file="buttons/save_cancel.tpl" but_name="dispatch[staff.update]" but_role="submit-link" but_target_form="staff_form" hide_first_button=$hide_first_button hide_second_button=$hide_second_button save=$id}
    {/if}
{/capture}

</form>

{/capture}

{include file="common/mainbox.tpl"
    title=($id) ? $person.name : __("staff.new_person")
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
    select_languages=true
}