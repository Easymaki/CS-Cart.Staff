<div class="ty-wysiwyg-content">
    <h1 class="ty-main-title">{$person.name}</h1>
    <div class="ty-column2">
        <div class="ty-content-reward-points__product-img">
            {include 
                file="common/image.tpl" 
                images=$person.main_pair 
                class="ty-pict cm-image"
            }
        </div>
    </div>
    <div class="ty-column2">
        <div class="ty-column1 ty-notice">
            <p>{__("email")}: <a href="mailto:{$person.email}">{$person.email}</a></p>
            <p>{__("gender")}: 
                {if $person.gender == 'M'}{__("male")}
                {else $person.gender == 'F'}{__("female")}
                {/if}
            </p>
            {foreach from=$countries.0 item=country}
                {if $person.country == $country.code}
                    <pƒ>{__("country")}: {$country.country}</p>
                {/if}
            {/foreach}
            {foreach from=$states.0 item=state}
                {if $person.state == $state.code}
                    <p>{__("state")}: {$state.state}</p>
                {/if}
            {/foreach}
            <p>{__("city")}: {$person.city}</p>
            <p>{__("address")}: {$person.adress}</p>
            <p>{__("post")}: {$person.post}</p>
            <p>{__("about")}: {$person.description}</p>
        </div>
    </div>
</div>