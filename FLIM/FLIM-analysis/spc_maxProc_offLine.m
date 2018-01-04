function spc_maxProc_offLine
global spc;
global gui;

page = str2num(get(gui.spc.spc_main.spc_page, 'String'));
spc.page = page;

stack_project = [];
for i = 1:length(spc.stack.image1)
    stack_project = [stack_project, reshape(sum(spc.stack.image1{i}, 1), spc.size(2), spc.size(3))];
end
spc.stack.project = reshape(stack_project, spc.size(2), spc.size(3), length(spc.stack.image1));

if ~spc.switches.noSPC
    [maxP, index_max] = max(spc.stack.project(:,:,page), [], 3);
    siz = size(spc.stack.image1{1});
    stack_max = zeros(siz);
    stack_max = stack_max(:);

    for i=1:length(page)
        %index = (index_max == page(i));
        index = (index_max == i);
        siz_index = size(index);
        index = repmat (index(:), [1,siz(1)]);
        index = reshape(index, siz_index(1), siz_index(2), spc.size(1));
        index = permute(index, [3,1,2]);
        index = index(:);
        stack_max = stack_max + index .* double(spc.stack.image1{page(i)}(:));
    end

    image1 = reshape(stack_max, siz);

    spc.imageMod = reshape(image1, siz);
    spc.project = reshape(sum(image1, 1), siz(2), siz(3));
end
%spc_redrawSetting;

try
    if spc.switches.redImg
        spc.state.img.greenMax = max(spc.state.img.greenImg(:,:,page), [], 3);
        spc.state.img.redMax = max(spc.state.img.redImg(:,:,page), [], 3);
    end
end