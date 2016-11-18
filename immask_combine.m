function out = immask_combine(a, b, mask_true_for_b)
    % blends two images using a mask
    assert_same_size(a,b);
    assert_same_size12(a,mask_true_for_b);
    
    out = immask(a, 1-mask_true_for_b) + immask(b, mask_true_for_b);