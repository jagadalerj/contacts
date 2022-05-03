// Contact listing javascript
const makeContactItemToHtml = (contact) => {
 if (contact) {
   return (
     `<div class="row">
      <div class="d-flex align-items-start p-2">
        <div class="w-100 overflow-hidden">
          <h5 class="mt-0 mb-0 font-14">
            ${contact?.name || ''}
          </h5>
          <p class="mt-1 mb-0 text-muted font-14">
            <span class="w-75">${contact?.number || ''}</span>
          </p>
        </div>
      </div>
    </div>`
   )
 }
 return (
   `<a href="javascript:void(0);" class="text-body">
     <div class="d-flex align-items-start p-2">
       <div class="w-100 overflow-hidden">
         <p class="mt-1 mb-0 text-muted font-14">
           <span class="w-75">No result found.</span>
         </p>
       </div>
     </div>
   </a>`
 );
 
}
 
const makeContactListItemsToHtml = (contactLists) => {
 if (contactLists.length < 1) {
   const noResultFound = makeContactItemToHtml('');
   $('.simplebar-content').html(noResultFound);
   return;
 }
 
 
 const contactListsHtml = $.map(contactLists, (contact) => {
   return makeContactItemToHtml(contact);
 });
 $('.simplebar-content').html(contactListsHtml)
}
 
 
// This function call '/contact_lists?q[name_or_number]=..' and get sorted result back.
const fetchContacts = (value) => {
 const searchParamValue = value || '';
 axios({
   url: `/contact_lists/search?q[name_or_number_cont]=${searchParamValue}`,
   method: 'get',
 }).then(function (response) {
   const contactLists = response?.data || [];
   makeContactListItemsToHtml(contactLists);
 })
   .catch(function (error) {
     console.log(error);
   })
}
 
function debounce(func, timeout = 300) {
 let timer;
 return (...args) => {
   clearTimeout(timer);
   timer = setTimeout(() => { func.apply(this, args); }, timeout);
 };
}